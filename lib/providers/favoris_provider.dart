import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/preferences_service.dart';
class FavorisProvider with ChangeNotifier {
  final PreferencesService _prefsService = PreferencesService();
  List<Article> _favoris = [];
  List<Article> get favoris => _favoris;
  FavorisProvider() {
    _chargerFavoris();
  }
  Future<void> _chargerFavoris() async {
    _favoris = await _prefsService.getFavoris();
    notifyListeners();
  }
  Future<void> toggleFavori(Article article) async {
    if (_favoris.any((s) => s.id == article.id)) {
      _favoris.removeWhere((s) => s.id == article.id);
    } else {
      _favoris.add(article);
    }
    await _prefsService.saveFavoris(_favoris);
    notifyListeners();
  }
  bool estFavori(int articleId) => _favoris.any((s) => s.id == articleId);
  }