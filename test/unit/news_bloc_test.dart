import 'package:bloc_test/bloc_test.dart';
import 'package:daily_tech_desk/news/data/models/article_model.dart';
import 'package:daily_tech_desk/news/domain/repositories/news_repository.dart';
import 'package:daily_tech_desk/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late MockNewsRepository mockRepository;
  late NewsBloc newsBloc;

  final testArticle = ArticleModel(
    id: 1,
    title: 'Flutter 3.29 Released',
    description: 'Exciting new features in Flutter and Dart.',
    sourceName: 'Flutter Dev',
    articleUrl: 'https://flutter.dev',
    publishedAt: DateTime(2026, 1, 1),
    category: 'flutter',
    readingTimeMinutes: 5,
  );

  final testArticles = [testArticle];

  setUp(() {
    mockRepository = MockNewsRepository();
    newsBloc = NewsBloc(mockRepository);
  });

  tearDown(() {
    newsBloc.close();
  });

  group('NewsBloc Tests', () {
    test('initial state is NewsInitial', () {
      expect(newsBloc.state, equals(NewsInitial()));
    });

    group('LoadNews Event', () {
      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsLoaded] when repository returns articles successfully',
        build: () {
          when(() => mockRepository.getArticles(page: 1, pageSize: 10))
              .thenAnswer((_) async => testArticles);
          return newsBloc;
        },
        act: (bloc) => bloc.add(const LoadNews(page: 1, pageSize: 10)),
        expect: () => [
          NewsLoading(),
          NewsLoaded(articles: testArticles),
        ],
        verify: (_) {
          verify(() => mockRepository.getArticles(page: 1, pageSize: 10)).called(1);
        },
      );

      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsError] when repository throws an exception',
        build: () {
          when(() => mockRepository.getArticles(page: 1, pageSize: 10))
              .thenThrow(Exception('Failed to fetch news'));
          return newsBloc;
        },
        act: (bloc) => bloc.add(const LoadNews(page: 1, pageSize: 10)),
        expect: () => [
          NewsLoading(),
          const NewsError(message: 'Exception: Failed to fetch news'),
        ],
        verify: (_) {
          verify(() => mockRepository.getArticles(page: 1, pageSize: 10)).called(1);
        },
      );
    });

    group('LoadCategoryNews Event', () {
      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsLoaded] when category filter returns articles successfully',
        build: () {
          when(() => mockRepository.getArticlesByCategory(
                category: 'flutter',
                page: 1,
                pageSize: 10,
              )).thenAnswer((_) async => testArticles);
          return newsBloc;
        },
        act: (bloc) => bloc.add(
          const LoadCategoryNews(category: 'flutter', page: 1, pageSize: 10),
        ),
        expect: () => [
          NewsLoading(),
          NewsLoaded(articles: testArticles),
        ],
        verify: (_) {
          verify(() => mockRepository.getArticlesByCategory(
                category: 'flutter',
                page: 1,
                pageSize: 10,
              )).called(1);
        },
      );

      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsError] when category request fails',
        build: () {
          when(() => mockRepository.getArticlesByCategory(
                category: 'invalid_category',
                page: 1,
                pageSize: 10,
              )).thenThrow(Exception('Category not found'));
          return newsBloc;
        },
        act: (bloc) => bloc.add(
          const LoadCategoryNews(
            category: 'invalid_category',
            page: 1,
            pageSize: 10,
          ),
        ),
        expect: () => [
          NewsLoading(),
          const NewsError(message: 'Exception: Category not found'),
        ],
        verify: (_) {
          verify(() => mockRepository.getArticlesByCategory(
                category: 'invalid_category',
                page: 1,
                pageSize: 10,
              )).called(1);
        },
      );
    });
  });
}
