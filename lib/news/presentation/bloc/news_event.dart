part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNews extends NewsEvent {
  final int page;
  final int pageSize;

  const LoadNews({
    this.page = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [page, pageSize];
}

class LoadCategoryNews extends NewsEvent {
  final String category;
  final int page;
  final int pageSize;

  const LoadCategoryNews({
    required this.category,
    this.page = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [category, page, pageSize];
}
