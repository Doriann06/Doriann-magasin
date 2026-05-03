import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/api.dart';
class ArticleProvider with ChangeNotifier {
  final ArticleApiService _apiService = ArticleApiService();
  List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;
  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Future<void> fetchArticles() async {
    _isLoading = true;
    _error = null;
    try {
      _articles = await _apiService.fetchArticles();
    } catch (e) {
      _error = 'Impossible de charger les articles';
      _articles = _apiService.getMockArticles(); // Affiche des données de secours en cas d'erreur
    } finally {
      _isLoading = false;
      // fetchArticles() est async : quand on arrive ici, le build est terminé.
      // notifyListeners() peut donc être appelé directement.
      notifyListeners();
    }
  }
  Future<Article> fetchArticleById(int id) async {
      return await _apiService.fetchArticleById(id);
  }
}