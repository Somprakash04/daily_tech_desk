import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';

abstract final class DummyNews {
  static final List<NewsArticle> articles = <NewsArticle>[
    NewsArticle(
      id: 'on-device-ai',
      title: 'On-device AI is reshaping how mobile apps feel',
      description:
          'Smaller, capable models are bringing faster and more private intelligence directly to everyday devices.',
      category: 'AI',
      source: 'Tech Signal',
      author: 'Maya Chen',
      publishedAt: DateTime(2026, 8, 18, 9, 30),
      imageUrl: 'https://picsum.photos/seed/daily-tech-ai/900/560',
      articleUrl: 'https://example.com',
    ),
    NewsArticle(
      id: 'flutter-performance',
      title: 'A practical guide to smoother Flutter interfaces',
      description:
          'The rendering habits that make the biggest difference when building responsive, polished Flutter screens.',
      category: 'Flutter',
      source: 'Flutter Weekly',
      author: 'Liam Patel',
      publishedAt: DateTime(2026, 8, 18, 7, 15),
      imageUrl: 'https://picsum.photos/seed/daily-tech-flutter/900/560',
      articleUrl: 'https://example.com',
    ),
    NewsArticle(
      id: 'open-source-maintainers',
      title: 'Open-source maintainers are rethinking sustainable funding',
      description:
          'New community-led models aim to support the people behind the tools developers rely on every day.',
      category: 'Open Source',
      source: 'The Dev Report',
      author: 'Noah Williams',
      publishedAt: DateTime(2026, 8, 17, 18, 0),
      imageUrl: 'https://picsum.photos/seed/daily-tech-source/900/560',
      articleUrl: 'https://example.com',
    ),
    NewsArticle(
      id: 'cloud-costs',
      title:
          'Cloud teams are putting cost visibility into the developer workflow',
      description:
          'FinOps tools are moving closer to code, helping teams understand trade-offs before a deployment.',
      category: 'Cloud',
      source: 'Cloud Native Today',
      author: 'Avery Singh',
      publishedAt: DateTime(2026, 8, 17, 13, 45),
      imageUrl: 'https://picsum.photos/seed/daily-tech-cloud/900/560',
      articleUrl: 'https://example.com',
    ),
    NewsArticle(
      id: 'security-passkeys',
      title: 'Passkeys are making security simpler for teams and users',
      description:
          'Adoption is accelerating as platforms standardize passwordless sign-in experiences.',
      category: 'Cyber Security',
      source: 'Secure Stack',
      author: 'Elena Rodriguez',
      publishedAt: DateTime(2026, 8, 16, 16, 20),
      imageUrl: 'https://picsum.photos/seed/daily-tech-security/900/560',
      articleUrl: 'https://example.com',
    ),
    NewsArticle(
      id: 'android-platform',
      title: 'Android developers are focusing on adaptive experiences',
      description:
          'New platform patterns help apps feel more natural across phones, tablets, foldables, and larger screens.',
      category: 'Android',
      source: 'Mobile Brief',
      author: 'Jordan Kim',
      publishedAt: DateTime(2026, 8, 16, 10, 0),
      imageUrl: 'https://picsum.photos/seed/daily-tech-android/900/560',
      articleUrl: 'https://example.com',
    ),
    NewsArticle(
      id: 'programming-principles',
      title: 'Simple programming principles that scale with a product',
      description:
          'Clear boundaries and small abstractions make teams faster without hiding the code that matters.',
      category: 'Programming',
      source: 'Codecraft',
      author: 'Priya Shah',
      publishedAt: DateTime(2026, 8, 15, 15, 30),
      imageUrl: 'https://picsum.photos/seed/daily-tech-code/900/560',
      articleUrl: 'https://example.com',
    ),
    NewsArticle(
      id: 'big-tech-infrastructure',
      title:
          'Big Tech infrastructure ideas are becoming accessible to small teams',
      description:
          'Managed services and open tools are lowering the cost of operating resilient software at scale.',
      category: 'Big Tech',
      source: 'Platform Review',
      author: 'Theo Martin',
      publishedAt: DateTime(2026, 8, 15, 9, 10),
      imageUrl: 'https://picsum.photos/seed/daily-tech-platform/900/560',
      articleUrl: 'https://example.com',
    ),
  ];
}
