import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_cubit.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testArticle1 = NewsArticle(
    id: 'art-001',
    title: 'Testing Flutter Apps with BLoC',
    description: 'Learn how to write unit and widget tests.',
    category: 'Flutter',
    source: 'Tech Daily',
    author: 'Som',
    publishedAt: DateTime(2026, 1, 15),
    imageUrl: 'https://example.com/flutter.png',
    articleUrl: 'https://example.com/flutter-test',
  );

  final testArticle2 = NewsArticle(
    id: 'art-002',
    title: 'ASP.NET Core 10 Web API Testing',
    description: 'A complete guide to Postman API automation.',
    category: 'Backend',
    source: 'DevDesk',
    author: 'Tester',
    publishedAt: DateTime(2026, 1, 16),
    imageUrl: 'https://example.com/dotnet.png',
    articleUrl: 'https://example.com/dotnet-test',
  );

  group('SavedArticlesCubit (Bookmarks & Offline Storage Tests)', () {
    test('initial state has empty articles list when SharedPreferences is empty', () async {
      SharedPreferences.setMockInitialValues({});
      final cubit = SavedArticlesCubit();
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.articles, isEmpty);
      await cubit.close();
    });

    test('loads saved articles from SharedPreferences on initialization', () async {
      final initialData = jsonEncode([testArticle1.toJson()]);
      SharedPreferences.setMockInitialValues({'saved_articles': initialData});

      final cubit = SavedArticlesCubit();
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.articles.length, equals(1));
      expect(cubit.state.articles.first.id, equals('art-001'));
      expect(cubit.state.contains('art-001'), isTrue);
      await cubit.close();
    });

    blocTest<SavedArticlesCubit, SavedArticlesState>(
      'toggles an article: adds article to saved list and persists to SharedPreferences',
      setUp: () {
        SharedPreferences.setMockInitialValues({});
      },
      build: () => SavedArticlesCubit(),
      act: (cubit) => cubit.toggle(testArticle1),
      expect: () => [
        SavedArticlesState(articles: [testArticle1]),
      ],
      verify: (cubit) async {
        final prefs = await SharedPreferences.getInstance();
        final stored = prefs.getString('saved_articles');
        expect(stored, isNotNull);
        expect(stored, contains('art-001'));
      },
    );

    blocTest<SavedArticlesCubit, SavedArticlesState>(
      'toggles an article again: removes article if already saved',
      setUp: () {
        SharedPreferences.setMockInitialValues({
          'saved_articles': jsonEncode([testArticle1.toJson()]),
        });
      },
      build: () => SavedArticlesCubit(),
      act: (cubit) async {
        await Future<void>.delayed(Duration.zero);
        await cubit.toggle(testArticle1);
      },
      expect: () => [
        SavedArticlesState(articles: [testArticle1]),
        const SavedArticlesState(articles: []),
      ],
      verify: (cubit) async {
        final prefs = await SharedPreferences.getInstance();
        final stored = prefs.getString('saved_articles');
        expect(stored, equals('[]'));
      },
    );

    blocTest<SavedArticlesCubit, SavedArticlesState>(
      'removes specific article via remove() method',
      setUp: () {
        SharedPreferences.setMockInitialValues({
          'saved_articles': jsonEncode([
            testArticle1.toJson(),
            testArticle2.toJson(),
          ]),
        });
      },
      build: () => SavedArticlesCubit(),
      act: (cubit) async {
        await Future<void>.delayed(Duration.zero);
        await cubit.remove(testArticle1);
      },
      expect: () => [
        SavedArticlesState(articles: [testArticle1, testArticle2]),
        SavedArticlesState(articles: [testArticle2]),
      ],
      verify: (cubit) {
        expect(cubit.state.contains('art-001'), isFalse);
        expect(cubit.state.contains('art-002'), isTrue);
      },
    );

    blocTest<SavedArticlesCubit, SavedArticlesState>(
      'clears all saved articles and removes storage key on clearAll()',
      setUp: () {
        SharedPreferences.setMockInitialValues({
          'saved_articles': jsonEncode([testArticle1.toJson()]),
        });
      },
      build: () => SavedArticlesCubit(),
      act: (cubit) async {
        await Future<void>.delayed(Duration.zero);
        await cubit.clearAll();
      },
      expect: () => [
        SavedArticlesState(articles: [testArticle1]),
        const SavedArticlesState(articles: []),
      ],
      verify: (cubit) async {
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.containsKey('saved_articles'), isFalse);
      },
    );
  });
}
