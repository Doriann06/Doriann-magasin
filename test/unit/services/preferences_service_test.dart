import 'package:flutter_test/flutter_test.dart';
import 'package:article_liste/services/preferences_service.dart';
import '../../helpers/test_data.dart';
import '../../mocks/mock_preferences_service.dart';

void main() {
  group('PreferencesService', () {
    test('getFavoris retourne une liste vide initialement', () async {
      final service = MockPreferencesService();
      final favoris = await service.getFavoris();
      expect(favoris, isEmpty);
    });
    test('saveFavoris puis getFavoris retourne les séries sauvegardées', () async {
      final service = MockPreferencesService();
      await service.saveFavoris([testArticle1,testArticle2]);
      final favoris = await service.getFavoris();
      expect(favoris.length, 2);
      expect(favoris[0].title, 'Classic Grey Hooded Sweatshirt');
    });
    test('saveFavoris remplaces les donnees précédentes', () async {
      final service = MockPreferencesService();
      await service.saveFavoris([testArticle1,testArticle2]);
      await service.saveFavoris([testArticle1]);
      final favoris = await service.getFavoris();
      expect(favoris.length, 1);
    });
});}