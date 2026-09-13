import '../../data/models/article_model.dart';

abstract class NewsRepository {
  Future<List<ArticleModel>> getArticles({
    int page,
    int pageSize,
  });

  Future<List<ArticleModel>> getArticlesByCategory({
    required String category,
    int page,
    int pageSize,
  });

  Future<List<ArticleModel>> searchArticles({
    required String query,
    int page,
    int pageSize,
  });
}