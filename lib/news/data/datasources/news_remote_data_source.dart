import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../models/article_model.dart';

class NewsRemoteDataSource {
  final ApiClient apiClient;

  NewsRemoteDataSource(this.apiClient);

  Future<List<ArticleModel>> getArticles({
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await apiClient.dio.get(
      '/articles',
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
      },
    );

    final data = response.data;

    final List articlesJson =
        data['articles'] ?? [];

    return articlesJson
        .map(
          (json) => ArticleModel.fromJson(json),
    )
        .toList();
  }

  Future<List<ArticleModel>> getArticlesByCategory({
    required String category,
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await apiClient.dio.get(
      '/articles/$category',
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
      },
    );

    final data = response.data;

    final List articlesJson =
        data['articles'] ?? [];

    return articlesJson
        .map(
          (json) => ArticleModel.fromJson(json),
    )
        .toList();
  }

  Future<List<ArticleModel>> searchArticles({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await apiClient.dio.get(
      '/articles/search',
      queryParameters: {
        'q': query,
        'page': page,
        'pageSize': pageSize,
      },
    );

    final data = response.data;

    final List articlesJson =
        data['articles'] ?? [];

    return articlesJson
        .map(
          (json) => ArticleModel.fromJson(json),
    )
        .toList();
  }

  Future<List<ArticleModel>> getDailyDigest({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await apiClient.dio.get(
      '/articles/daily-digest',
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
      },
    );

    final data = response.data;

    final List articlesJson = data['articles'] ?? [];

    return articlesJson
        .map(
          (json) => ArticleModel.fromJson(json),
    )
        .toList();
  }
}