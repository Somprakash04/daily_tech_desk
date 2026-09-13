import 'package:daily_tech_desk/core/routes/app_routes.dart';
import 'package:daily_tech_desk/core/widgets/app_back_button.dart';
import 'package:daily_tech_desk/features/home/presentation/widgets/news_card.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_cubit.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SavedItemsPage extends StatelessWidget {
  const SavedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(
          fallbackRoute: AppRoutes.home,
        ),
        title: const Text(
          'Saved Items',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocBuilder<SavedArticlesCubit, SavedArticlesState>(
        builder: (
          BuildContext context,
          SavedArticlesState state,
        ) {
          if (state.articles.isEmpty) {
            return const _EmptySavedItems();
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              24,
            ),
            itemCount: state.articles.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              final article = state.articles[index];

              return NewsCard(
                article: article,
                isSaved: true,
                onBookmark: () {
                  context.read<SavedArticlesCubit>().toggle(article);
                },
                onTap: () {
                  context.push(
                    AppRoutes.articleDetails,
                    extra: article,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptySavedItems extends StatelessWidget {
  const _EmptySavedItems();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bookmark_border_rounded,
              size: 56,
              color: colors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No saved items yet.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Bookmark stories from your feed '
              'to read them later, even offline.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
