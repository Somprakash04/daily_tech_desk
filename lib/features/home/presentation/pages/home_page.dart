import 'package:daily_tech_desk/core/constants/app_constants.dart';
import 'package:daily_tech_desk/core/dummy_data/dummy_categories.dart';
import 'package:daily_tech_desk/core/dummy_data/dummy_user.dart';
import 'package:daily_tech_desk/core/theme/theme_cubit.dart';
import 'package:daily_tech_desk/core/network/api_client.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_cubit.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_state.dart';
import 'package:daily_tech_desk/features/home/data/repositories/api_news_repository.dart';
import 'package:daily_tech_desk/features/home/presentation/cubit/feed_filter_cubit.dart';
import 'package:daily_tech_desk/features/home/presentation/cubit/news_cubit.dart';
import 'package:daily_tech_desk/features/home/presentation/cubit/news_state.dart';
import 'package:daily_tech_desk/features/home/presentation/widgets/app_drawer.dart';
import 'package:daily_tech_desk/features/home/presentation/widgets/news_card.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_cubit.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_state.dart';
import 'package:daily_tech_desk/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (_) => NewsCubit(
        ApiNewsRepository(
          NewsRemoteDataSource(
            ApiClient(),
          ),
        ),
      ),
      child: BlocProvider<FeedFilterCubit>(
        create: (_) => FeedFilterCubit(),
        child: const _HomeView(),
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  List<String> _lastLoadedInterests = const <String>[];
  bool _hasLoadedNews = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authState = context.watch<AuthSessionCubit>().state;

    if (authState.status != AuthSessionStatus.signedIn) {
      return;
    }

    final interests = List<String>.unmodifiable(
      authState.interestIds,
    );

    if (_hasLoadedNews && _sameInterests(
      interests,
      _lastLoadedInterests,
    )) {
      return;
    }

    _lastLoadedInterests = interests;
    _hasLoadedNews = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<NewsCubit>().loadPersonalizedNews(
        interests,
      );
    });
  }

  bool _sameInterests(
      List<String> first,
      List<String> second,
      ) {
    if (first.length != second.length) {
      return false;
    }

    for (int i = 0; i < first.length; i++) {
      if (first[i] != second[i]) {
        return false;
      }
    }

    return true;
  }

  List<String> _categoryIds(List<String> interestIds) {
    if (interestIds.isEmpty) {
      return DummyCategories.defaultHomeCategoryIds;
    }

    if (interestIds.contains(
      DummyCategories.allTechnologyId,
    )) {
      return DummyCategories.interests
          .where(
            (topic) =>
        topic.id != DummyCategories.allTechnologyId,
      )
          .map((topic) => topic.id)
          .toList(growable: false);
    }

    return interestIds;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthSessionCubit, AuthSessionState>(
      builder: (
          BuildContext context,
          AuthSessionState authState,
          ) {
        final List<String> categoryIds =
        _categoryIds(authState.interestIds);

        final Map<String, String> labels = <String, String>{
          for (final item in DummyCategories.interests)
            item.id: item.label,
        };

        return Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(
            titleSpacing: 0,
            title: const Row(
              children: <Widget>[
                Icon(Icons.newspaper_rounded),
                SizedBox(width: 10),
                Text(
                  AppConstants.appName,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (
                    BuildContext context,
                    ThemeMode mode,
                    ) {
                  final bool isDark =
                      mode == ThemeMode.dark ||
                          (mode == ThemeMode.system &&
                              Theme.of(context).brightness ==
                                  Brightness.dark);

                  return IconButton(
                    tooltip: isDark
                        ? 'Switch to light theme'
                        : 'Switch to dark theme',
                    onPressed: () =>
                        context.read<ThemeCubit>().toggle(
                          Theme.of(context).brightness,
                        ),
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                    ),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 760,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        14,
                        20,
                        6,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Good to see you, '
                                '${DummyUser.current.firstName}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                              fontWeight:
                              FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Today in tech',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge,
                          ),
                        ],
                      ),
                    ),

                    // Personalized technology chips
                    SizedBox(
                      height: 52,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 6,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryIds.length + 1,
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 8),
                        itemBuilder: (_, int index) {
                          final String? category =
                          index == 0
                              ? null
                              : categoryIds[index - 1];

                          final String label = category == null
                              ? DummyCategories.allFeedLabel
                              : labels[category] ?? category;

                          return BlocBuilder<
                              FeedFilterCubit,
                              String?>(
                            builder: (
                                BuildContext context,
                                String? selectedCategory,
                                ) {
                              return ChoiceChip(
                                label: Text(label),
                                selected:
                                selectedCategory ==
                                    category,
                                onSelected: (_) {
                                  context
                                      .read<FeedFilterCubit>()
                                      .select(category);

                                  if (category == null) {
                                    context
                                        .read<NewsCubit>()
                                        .loadPersonalizedNews(
                                      authState.interestIds,
                                    );
                                  } else {
                                    context
                                        .read<NewsCubit>()
                                        .loadCategory(
                                      category,
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),

                    Expanded(
                      child: BlocBuilder<
                          NewsCubit,
                          NewsState>(
                        builder: (
                            BuildContext context,
                            NewsState state,
                            ) {
                          if (state.status ==
                              NewsStatus.loading ||
                              state.status ==
                                  NewsStatus.initial) {
                            return const Center(
                              child:
                              CircularProgressIndicator(),
                            );
                          }

                          if (state.status ==
                              NewsStatus.failure) {
                            return Center(
                              child: FilledButton(
                                onPressed: () {
                                  context
                                      .read<NewsCubit>()
                                      .loadPersonalizedNews(
                                    authState.interestIds,
                                  );
                                },
                                child:
                                const Text('Try again'),
                              ),
                            );
                          }

                          return BlocBuilder<
                              SavedArticlesCubit,
                              SavedArticlesState>(
                            builder: (
                                BuildContext context,
                                SavedArticlesState savedState,
                                ) {
                              return BlocBuilder<
                                  FeedFilterCubit,
                                  String?>(
                                builder: (
                                    BuildContext context,
                                    String? selectedCategory,
                                    ) {
                                  final displayedArticles =
                                  selectedCategory == null
                                      ? state.articles
                                      : state.articles
                                      .where(
                                        (article) =>
                                    article.category ==
                                        selectedCategory,
                                  )
                                      .toList(
                                    growable: false,
                                  );

                                  if (displayedArticles
                                      .isEmpty) {
                                    return const Center(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.all(24),
                                        child: Text(
                                          'No news is available for this technology yet.',
                                          textAlign:
                                          TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    padding:
                                    const EdgeInsets.fromLTRB(
                                      20,
                                      10,
                                      20,
                                      24,
                                    ),
                                    itemCount:
                                    displayedArticles.length,
                                    itemBuilder: (
                                        _,
                                        int index,
                                        ) {
                                      final article =
                                      displayedArticles[
                                      index];

                                      return NewsCard(
                                        article: article,
                                        isSaved: savedState.contains(article.id),
                                        onBookmark: () {
                                          context.read<SavedArticlesCubit>().toggle(article);
                                        },
                                        onTap: () {
                                          context.push(
                                            '/article-details',
                                            extra: article,
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}