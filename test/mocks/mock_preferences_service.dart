import 'package:article_liste/models/article.dart';
import 'package:article_liste/services/preferences_service.dart';
/// Substitut de PreferencesService qui stocke en mémoire au lieu de SharedPreferences.
class MockPreferencesService extends PreferencesService {
  List<Article> _favoris = [];

  @override
  Future<List<Article>> getFavoris() async => List.from(_favoris);

  @override
  Future<void> saveFavoris(List<Article> favoris) async {
    _favoris = List.from(favoris);
  }
  
}