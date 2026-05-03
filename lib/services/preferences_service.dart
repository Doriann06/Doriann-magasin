import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';
class PreferencesService {
  static const String _favoritesKey = 'favoris';

  Future<List<Article>> getFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_favoritesKey);
    if (jsonStr==null) return [];

    final List<dynamic> data = jsonDecode(jsonStr);
    return data.map((j) => Article.fromJson(j)).toList();
    }
    Future<void> saveFavoris(List<Article> favoris) async {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = jsonEncode(favoris.map((s) => s.toJson()).toList());
      await prefs.setString(_favoritesKey, jsonStr);
    }
  
}