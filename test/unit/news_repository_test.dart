import 'package:daily_tech_desk/news/data/datasources/news_remote_data_source.dart';
import 'package:daily_tech_desk/news/data/models/article_model.dart';
import 'package:daily_tech_desk/news/data/repositories/news_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

void main() {
  late MockNewsRemoteDataSource mockDataSource;
  late NewsRepositoryImpl repository;

  final sampleArticle = ArticleModel(
    id: 101,
    title: 'Clean Architecture with Flutter',
    description: 'Separation of concerns in mobile apps.',
    imageUrl: 'https://example.com/clean.png',
    author: 'Robert Martin',
    sourceName: 'TechDesk',
    articleUrl: 'https://example.com/clean-arch',
    publishedAt: DateTime(2026, 2, 20),
    category: 'programming',
    readingTimeMinutes: 7,
  );

  setUp(() {
    mockDataSource = MockNewsRemoteDataSource();
    repository = NewsRepositoryImpl(mockDataSource);
  });

  group('NewsRepositoryImpl Unit Tests (mocktail)', () {
    test('getArticles delegates call to remoteDataSource with pagination params', () async {
      when(() => mockDataSource.getArticles(page: 2, pageSize: 15))
          .thenAnswer((_) async => [sampleArticle]);

      final result = await repository.getArticles(page: 2, pageSize: 15);

      expect(result, equals([sampleArticle]));
      verify(() => mockDataSource.getArticles(page: 2, pageSize: 15)).called(1);
    });

    test('getArticlesByCategory calls remoteDataSource with specified category', () async {
      when(() => mockDataSource.getArticlesByCategory(
            category: 'ai-ml',
            page: 1,
            pageSize: 10,
          )).thenAnswer((_) async => [sampleArticle]);

      final result = await repository.getArticlesByCategory(
        category: 'ai-ml',
        page: 1,
        pageSize: 10,
      );

      expect(result, equals([sampleArticle]));
      verify(() => mockDataSource.getArticlesByCategory(
            category: 'ai-ml',
            page: 1,
            pageSize: 10,
          )).called(1);
    });

    test('searchArticles calls remoteDataSource with search query', () async {
      when(() => mockDataSource.searchArticles(
            query: 'flutter',
            page: 1,
            pageSize: 10,
          )).thenAnswer((_) async => [sampleArticle]);

      final result = await repository.searchArticles(
        query: 'flutter',
        page: 1,
        pageSize: 10,
      );

      expect(result, equals([sampleArticle]));
      verify(() => mockDataSource.searchArticles(
            query: 'flutter',
            page: 1,
            pageSize: 10,
          )).called(1);
    });

    test('propagates exception when remoteDataSource fails', () async {
      when(() => mockDataSource.getArticles(page: 1, pageSize: 10))
          .thenThrow(Exception('Server unreachable (500)'));

      expect(
        () => repository.getArticles(page: 1, pageSize: 10),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('ArticleModel Data Parsing Unit Tests', () {
    test('parses complete JSON response correctly', () {
      final json = {
        'id': 1,
        'title': 'Test Article',
        'description': 'Test Description',
        'imageUrl': 'https://image.png',
        'author': 'Tester',
        'sourceName': 'Daily Desk',
        'articleUrl': 'https://article.url',
        'publishedAt': '2026-03-01T12:00:00Z',
        'category': 'devops',
        'readingTimeMinutes': 4,
      };

      final article = ArticleModel.fromJson(json);

      expect(article.id, equals(1));
      expect(article.title, equals('Test Article'));
      expect(article.category, equals('devops'));
      expect(article.readingTimeMinutes, equals(4));
      expect(article.sourceName, equals('Daily Desk'));
    });

    test('handles missing or nullable fields with default fallbacks gracefully', () {
      final minimalJson = {
        'publishedAt': '2026-03-01T12:00:00Z',
      };

      final article = ArticleModel.fromJson(minimalJson);

      expect(article.id, equals(0));
      expect(article.title, equals(''));
      expect(article.description, isNull);
      expect(article.readingTimeMinutes, equals(1));
    });
  });
}
