import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:equatable/equatable.dart';

enum NewsStatus {
  initial,
  loading,
  success,
  failure,
}

class NewsState extends Equatable {
  const NewsState({
    this.status = NewsStatus.initial,
    this.articles = const <NewsArticle>[],
    this.selectedCategory,
  });

  final NewsStatus status;
  final List<NewsArticle> articles;
  final String? selectedCategory;

  NewsState copyWith({
    NewsStatus? status,
    List<NewsArticle>? articles,
    String? selectedCategory,
    bool clearCategory = false,
  }) {
    return NewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      selectedCategory:
      clearCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    articles,
    selectedCategory,
  ];
}