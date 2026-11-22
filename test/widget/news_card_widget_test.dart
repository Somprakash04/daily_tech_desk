import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:daily_tech_desk/features/home/presentation/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sampleArticle = NewsArticle(
    id: 'art-widget-1',
    title: 'Automated Testing with Flutter and Dart',
    description: 'A deep dive into widget and unit testing for QA engineers.',
    category: 'Flutter',
    source: 'Tech Desk Daily',
    author: 'QA Lead',
    publishedAt: DateTime(2026, 3, 10),
    imageUrl: 'https://example.com/flutter.png',
    articleUrl: 'https://example.com/flutter-article',
  );

  Widget createWidgetUnderTest({
    required NewsArticle article,
    required bool isSaved,
    required VoidCallback onBookmark,
    VoidCallback? onTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: NewsCard(
            article: article,
            isSaved: isSaved,
            onBookmark: onBookmark,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  group('NewsCard Widget Tests (flutter_test)', () {
    testWidgets('renders article title, category chip, and source metadata', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          article: sampleArticle,
          isSaved: false,
          onBookmark: () {},
        ),
      );

      // Verify category chip
      expect(find.text('Flutter'), findsOneWidget);

      // Verify article title
      expect(find.text('Automated Testing with Flutter and Dart'), findsOneWidget);

      // Verify description
      expect(
        find.text('A deep dive into widget and unit testing for QA engineers.'),
        findsOneWidget,
      );

      // Verify source metadata is rendered in row
      expect(find.textContaining('Tech Desk Daily'), findsOneWidget);
    });

    testWidgets('displays outline bookmark icon when article is not saved', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          article: sampleArticle,
          isSaved: false,
          onBookmark: () {},
        ),
      );

      expect(find.byIcon(Icons.bookmark_border_rounded), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_rounded), findsNothing);
    });

    testWidgets('displays filled bookmark icon when article is saved', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          article: sampleArticle,
          isSaved: true,
          onBookmark: () {},
        ),
      );

      expect(find.byIcon(Icons.bookmark_rounded), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_border_rounded), findsNothing);
    });

    testWidgets('triggers onBookmark callback when bookmark icon button is tapped', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      var bookmarkTapped = false;

      await tester.pumpWidget(
        createWidgetUnderTest(
          article: sampleArticle,
          isSaved: false,
          onBookmark: () {
            bookmarkTapped = true;
          },
        ),
      );

      final bookmarkButton = find.byIcon(Icons.bookmark_border_rounded);
      await tester.tap(bookmarkButton);
      await tester.pump();

      expect(bookmarkTapped, isTrue);
    });

    testWidgets('triggers onTap callback when the card is clicked', (tester) async {
      var cardTapped = false;

      await tester.pumpWidget(
        createWidgetUnderTest(
          article: sampleArticle,
          isSaved: false,
          onBookmark: () {},
          onTap: () {
            cardTapped = true;
          },
        ),
      );

      final cardFinder = find.byType(InkWell);
      await tester.tap(cardFinder.first);
      await tester.pump();

      expect(cardTapped, isTrue);
    });
  });
}
