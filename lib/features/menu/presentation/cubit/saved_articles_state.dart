import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:equatable/equatable.dart';

class SavedArticlesState extends Equatable {
  const SavedArticlesState({this.articles = const <NewsArticle>[]});

  final List<NewsArticle> articles;

  bool contains(String articleId) =>
      articles.any((NewsArticle article) => article.id == articleId);

  @override
  List<Object> get props => <Object>[articles];
}
