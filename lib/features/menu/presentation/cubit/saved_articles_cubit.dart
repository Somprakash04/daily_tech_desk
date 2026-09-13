import 'dart:convert';

import 'package:daily_tech_desk/features/home/domain/entities/news_article.dart';
import 'package:daily_tech_desk/features/menu/presentation/cubit/saved_articles_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedArticlesCubit extends Cubit<SavedArticlesState> {
  SavedArticlesCubit() : super(const SavedArticlesState()) {
    _loadSavedArticles();
  }

  static const String _storageKey = 'saved_articles';

  Future<void> _loadSavedArticles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? storedData = prefs.getString(_storageKey);

    if (storedData == null || storedData.isEmpty) {
      return;
    }

    try {
      final List<dynamic> jsonList = jsonDecode(storedData);

      final List<NewsArticle> articles = jsonList
          .map(
            (dynamic item) =>
            NewsArticle.fromJson(Map<String, dynamic>.from(item as Map)),
      )
          .toList();

      emit(
        SavedArticlesState(
          articles: List<NewsArticle>.unmodifiable(articles),
        ),
      );
    } catch (_) {
      await prefs.remove(_storageKey);
    }
  }

  Future<void> toggle(NewsArticle article) async {
    final List<NewsArticle> articles =
    List<NewsArticle>.of(state.articles);

    if (state.contains(article.id)) {
      articles.removeWhere(
            (NewsArticle item) => item.id == article.id,
      );
    } else {
      articles.add(article);
    }

    final SavedArticlesState newState = SavedArticlesState(
      articles: List<NewsArticle>.unmodifiable(articles),
    );

    emit(newState);

    await _saveArticles(newState.articles);
  }

  Future<void> _saveArticles(List<NewsArticle> articles) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    final String encoded = jsonEncode(
      articles
          .map((NewsArticle article) => article.toJson())
          .toList(),
    );

    await prefs.setString(_storageKey, encoded);
  }

  Future<void> remove(NewsArticle article) async {
    final List<NewsArticle> articles =
    List<NewsArticle>.of(state.articles)
      ..removeWhere(
            (NewsArticle item) => item.id == article.id,
      );

    final SavedArticlesState newState = SavedArticlesState(
      articles: List<NewsArticle>.unmodifiable(articles),
    );

    emit(newState);

    await _saveArticles(newState.articles);
  }

  Future<void> clearAll() async {
    emit(const SavedArticlesState());

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.remove(_storageKey);
  }
}