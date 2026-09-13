part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadNews extends NewsEvent {
  final int page;
  final int pageSize;

  LoadNews({
    this.page = 1,
    this.pageSize = 10,
  });
}

class LoadCategoryNews extends NewsEvent {
  final String category;
  final int page;
  final int pageSize;

  LoadCategoryNews({
    required this.category,
    this.page = 1,
    this.pageSize = 10,
  });
}