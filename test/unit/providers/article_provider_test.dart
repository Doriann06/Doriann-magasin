import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:article_liste/providers/article_provider.dart';
// Pour tester ArticleProvider de façon isolée, nous allons observer
// son comportement via ses getters publics. 
void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Nécessaire pour tester les ChangeNotifier avec des appels async
  group('ArticleProvider', () {
    test('état initial:liste vide, pas de chargement', () {
      final provider = ArticleProvider();
      expect(provider.articles, isEmpty);
      expect(provider.isLoading, isFalse);
      expect(provider.error, isNull);
    });
    test('notifie les listeners quand fetchArticles est appelé', () async {
      final provider = ArticleProvider();
      var notified = false;
      provider.addListener(() => notified = true);
      // fetchArticles tente un vrai appel réseau ici — il tombera en erreur
      // mais notifiera quand même (fallback mock).
      await provider.fetchArticles();
      await Future.delayed(const Duration(microseconds: 50)); // Laisser le temps à notifyListeners() de s'exécuter
      expect(notified, isTrue);
    });
  });
}