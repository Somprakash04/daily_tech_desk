import 'package:daily_tech_desk/core/network/api_client.dart';
import 'package:daily_tech_desk/features/home/data/repositories/api_news_repository.dart';
import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:daily_tech_desk/features/home/presentation/widgets/news_card.dart';
import 'package:daily_tech_desk/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_cubit.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_state.dart';
import 'package:go_router/go_router.dart';

class DailyDigestPage extends StatefulWidget {
  const DailyDigestPage({super.key});

  @override
  State<DailyDigestPage> createState() => _DailyDigestPageState();
}

class _DailyDigestPageState extends State<DailyDigestPage> {
  late final ApiNewsRepository _repository;

  bool _isLoading = true;
  String? _errorMessage;
  List<NewsArticle> _articles = const <NewsArticle>[];

  @override
  void initState() {
    super.initState();

    _repository = ApiNewsRepository(
      NewsRemoteDataSource(
        ApiClient(),
      ),
    );

    _loadDailyDigest();
  }

  Future<void> _loadDailyDigest() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final List<NewsArticle> articles =
      await _repository.getDailyDigest(
        page: 1,
        pageSize: 20,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage =
        'Unable to load today\'s technology news.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        title: const Text(
          'Daily Digest',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.cloud_off_rounded,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _loadDailyDigest,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    if (_articles.isEmpty) {
      return RefreshIndicator(
        onRefresh: _loadDailyDigest,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const <Widget>[
            SizedBox(height: 180),
            Center(
              child: Text(
                'No technology news available today.',
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadDailyDigest,
      child: BlocBuilder<SavedArticlesCubit, SavedArticlesState>(
        builder: (
            BuildContext context,
            SavedArticlesState savedState,
            ) {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              24,
            ),
            itemCount: _articles.length,
            itemBuilder: (
                BuildContext context,
                int index,
                ) {
              final NewsArticle article = _articles[index];

              return _DailyDigestArticleCard(
                article: article,
                isSaved: savedState.contains(article.id),
                onBookmark: () {
                  context
                      .read<SavedArticlesCubit>()
                      .toggle(article);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _DailyDigestArticleCard extends StatelessWidget {
  const _DailyDigestArticleCard({
    required this.article,
    required this.isSaved,
    required this.onBookmark,
  });

  final NewsArticle article;
  final bool isSaved;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    // NewsCard already displays the article category.
    return NewsCard(
      article: article,
      isSaved: isSaved,
      onBookmark: onBookmark,
      onTap: () {
        context.push(
          '/article-details',
          extra: article,
        );
      },
    );
  }
}