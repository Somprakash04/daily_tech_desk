import 'package:daily_tech_desk/features/home/domain/repositories/news_repository.dart';
import 'package:daily_tech_desk/features/home/presentation/cubit/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._newsRepository)
      : super(const NewsState());

  final NewsRepository _newsRepository;

  Future<void> loadPersonalizedNews(
      List<String> interestIds,
      ) async {
    emit(
      state.copyWith(
        status: NewsStatus.loading,
        clearCategory: true,
      ),
    );

    try {
      final articles = await _newsRepository.getNews(
        interestIds: interestIds,
      );

      emit(
        NewsState(
          status: NewsStatus.success,
          articles: articles,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: NewsStatus.failure,
        ),
      );
    }
  }

  Future<void> loadCategory(String category) async {
    emit(
      state.copyWith(
        status: NewsStatus.loading,
        selectedCategory: category,
      ),
    );

    try {
      final articles =
      await _newsRepository.getNewsByCategory(
        category: category,
        page: 1,
        pageSize: 10,
      );

      emit(
        NewsState(
          status: NewsStatus.success,
          articles: articles,
          selectedCategory: category,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: NewsStatus.failure,
          selectedCategory: category,
        ),
      );
    }
  }
  Future<void> loadDailyDigest() async {
    emit(
      state.copyWith(
        status: NewsStatus.loading,
        clearCategory: true,
      ),
    );

    try {
      final articles =
      await _newsRepository.getDailyDigest(
        page: 1,
        pageSize: 20,
      );

      emit(
        NewsState(
          status: NewsStatus.success,
          articles: articles,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: NewsStatus.failure,
        ),
      );
    }
  }
}