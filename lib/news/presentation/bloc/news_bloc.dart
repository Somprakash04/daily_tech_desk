import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/presentation/cubit/news_state.dart';
import '../../data/models/article_model.dart';
import '../../domain/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<LoadCategoryNews>(_onLoadCategoryNews);
  }

  Future<void> _onLoadNews(
      LoadNews event,
      Emitter<NewsState> emit,
      ) async {
    emit(NewsLoading());

    try {
      final articles = await repository.getArticles(
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(
        NewsLoaded(
          articles: articles,
        ),
      );
    } catch (e) {
      emit(
        NewsError(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadCategoryNews(
      LoadCategoryNews event,
      Emitter<NewsState> emit,
      ) async {
    emit(NewsLoading());

    try {
      final articles =
      await repository.getArticlesByCategory(
        category: event.category,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(
        NewsLoaded(
          articles: articles,
        ),
      );
    } catch (e) {
      emit(
        NewsError(
          message: e.toString(),
        ),
      );
    }
  }
}