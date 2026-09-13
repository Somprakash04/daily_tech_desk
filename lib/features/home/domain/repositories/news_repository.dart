import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';

abstract interface class NewsRepository {
  Future<List<NewsArticle>> getNews({
    List<String> interestIds,
  });

  Future<List<NewsArticle>> getNewsByCategory({
    required String category,
    int page,
    int pageSize,
  });

  Future<List<NewsArticle>> getDailyDigest({
    int page,
    int pageSize,
  });
}