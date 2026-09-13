import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:daily_tech_desk/features/home/domain/repositories/news_repository.dart';

import '../../../../news/data/datasources/news_remote_data_source.dart';
import '../../../../news/data/models/article_model.dart';

class ApiNewsRepository implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  ApiNewsRepository(this.remoteDataSource);

  @override
  Future<List<NewsArticle>> getNews({
    List<String> interestIds = const <String>[],
  }) async {
    if (interestIds.isEmpty) {
      final List<ArticleModel> articles =
      await remoteDataSource.getArticles(
        page: 1,
        pageSize: 10,
      );

      return articles.map(_mapToNewsArticle).toList();
    }

    final List<NewsArticle> allArticles = <NewsArticle>[];

    for (final String category in interestIds) {
      final List<ArticleModel> articles =
      await remoteDataSource.getArticlesByCategory(
        category: category,
        page: 1,
        pageSize: 10,
      );

      allArticles.addAll(
        articles.map(_mapToNewsArticle),
      );
    }

    final Map<String, NewsArticle> uniqueArticles =
    <String, NewsArticle>{
      for (final NewsArticle article in allArticles)
        article.id: article,
    };

    final List<NewsArticle> result =
    uniqueArticles.values.toList();

    result.sort(
          (NewsArticle a, NewsArticle b) =>
          b.publishedAt.compareTo(a.publishedAt),
    );

    return result;
  }

  @override
  Future<List<NewsArticle>> getNewsByCategory({
    required String category,
    int page = 1,
    int pageSize = 10,
  }) async {
    final List<ArticleModel> articles =
    await remoteDataSource.getArticlesByCategory(
      category: category,
      page: page,
      pageSize: pageSize,
    );

    return articles.map(_mapToNewsArticle).toList();
  }

  NewsArticle _mapToNewsArticle(
      ArticleModel article,
      ) {
    return NewsArticle(
      id: article.id.toString(),
      title: article.title,
      description:
      article.description ?? 'No description available.',
      category: article.category,
      source: article.sourceName,
      author: article.author ?? 'Unknown',
      publishedAt: article.publishedAt,
      imageUrl: article.imageUrl ?? '',
      articleUrl: article.articleUrl,
    );


  }

  @override
  Future<List<NewsArticle>> getDailyDigest({
    int page = 1,
    int pageSize = 20,
  }) async {
    final List<ArticleModel> articles =
    await remoteDataSource.getDailyDigest(
      page: page,
      pageSize: pageSize,
    );

    return articles.map(_mapToNewsArticle).toList();
  }
}