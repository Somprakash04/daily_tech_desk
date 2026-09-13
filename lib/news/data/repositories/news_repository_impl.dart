import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';
import '../models/article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ArticleModel>> getArticles({
    int page = 1,
    int pageSize = 10,
  }) {
    return remoteDataSource.getArticles(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<List<ArticleModel>> getArticlesByCategory({
    required String category,
    int page = 1,
    int pageSize = 10,
  }) {
    return remoteDataSource.getArticlesByCategory(
      category: category,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<List<ArticleModel>> searchArticles({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) {
    return remoteDataSource.searchArticles(
      query: query,
      page: page,
      pageSize: pageSize,
    );
  }
}