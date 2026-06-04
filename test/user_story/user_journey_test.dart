// User story Marie : ouvre l'app, consulte le détail d'un article,
// l'ajoute aux favoris et au pannier.
//
// Couvre simultanément : 4 écrans, 3 providers, GoRouter et la chaîne
// d'injection de dépendance avec 3 fakes en mémoire (pas d'I/O réelle,
// le clock simulé de testWidgets ne supporte pas SQLite/FFI).
// Sinon il faut faire un test avec une vraie BD et un device pour lancer l'app

import 'dart:convert';
import 'package:article_liste/providers/historique_pannier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:article_liste/models/pannier.dart';
import 'package:article_liste/providers/favoris_provider.dart';
import 'package:article_liste/providers/article_provider.dart';
import 'package:article_liste/router.dart';
import 'package:article_liste/services/api.dart';
import 'package:article_liste/services/pannier_database_service.dart';
import '../mocks/mock_preferences_service.dart';

final articleJson =[
        {
          'id': 5,
          'title': 'Classic Grey Hooded Sweatshirt',
          'slug': 'classic-grey-hooded-sweatshirt',
          'description': 'Elevate your casual wear with our Classic Grey Hooded Sweatshirt. Made from a soft cotton blend, this hoodie features a front kangaroo pocket, an adjustable drawstring hood, and ribbed cuffs for a snug fit. Perfect for those chilly evenings or lazy weekends, it pairs effortlessly with your favorite jeans or joggers.',
          'images': ['https://example.com/bb.jpg'],
          'price': 79,
        },
        {
          'id': 2,
          'title': 'Classic Red Pullover Hoodie',
          'slug': 'science-fiction',
          'status': 'Running',
          'images': ['https://example.com/st.jpg'],
          'description': 'Elevate your casual wardrobe with our Classic Red Pullover Hoodie. Crafted with a soft cotton blend for ultimate comfort, this vibrant red hoodie features a kangaroo pocket, adjustable drawstring hood, and ribbed cuffs for a snug fit. The timeless design ensures easy pairing with jeans or joggers for a relaxed yet stylish look, making it a versatile addition to your everyday attire.',
          'price': 10,
        },
      ];

class _TvmazeMockHttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final detail = RegExp(r'^/shows/(\d+)$').firstMatch(request.url.path);
    final dynamic body = detail != null
        ? articleJson.firstWhere((s) => s['id'] == int.parse(detail.group(1)!))
        : articleJson;
    return http.StreamedResponse(
      Stream.value(utf8.encode(jsonEncode(body))),
      200,
      headers: {'content-type': 'application/json'},
    );
  }
}

// Substitut en mémoire — évite SQLite/FFI sous le clock simulé de testWidgets
class _InMemoryWatchlistDb extends PannierDatabaseService {
  final List<Pannier> _items = [];

  @override
  Future<List<Pannier>> getPannier() async => List.from(_items);

  @override
  Future<void> savePannier(List<Pannier> items) async {
    _items
      ..clear()
      ..addAll(items);
  }

  @override
  Future<void> clearPannier() async => _items.clear();

  @override
  Future<void> close() async {}
}

// Pump multiple frames pour drainer les microtâches (mock HTTP), terminer
// les transitions de page (~300ms) et laisser la route précédente se
// disposer complètement. Pas de pumpAndSettle car le CircularProgressIndicator
// ferait boucler indéfiniment.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 15; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'parcours utilisateur : liste → détail → favoris + watchlist → changement de statut',
    (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ArticleProvider(
                apiService: ArticleApiService(client: _TvmazeMockHttpClient()),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) =>
                  FavorisProvider(prefsService: MockPreferencesService()),
            ),
            ChangeNotifierProvider(
              create: (_) => HistoriquePannierProvider(dbService: _InMemoryWatchlistDb()),
            ),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await _settle(tester);

      // 1. Liste affichée
      expect(find.text('ArticleListe'), findsOneWidget);
      expect(find.text('Classic Grey Hooded Sweatshirt'), findsOneWidget);
      expect(find.text('Classic Red Pullover Hoodie'), findsOneWidget);

      // 2. Tap → détail
      await tester.tap(find.text('Classic Grey Hooded Sweatshirt'));
      await _settle(tester);
      expect(find.text('Détail'), findsOneWidget);
      expect(find.text('Ajouter aux favoris'), findsOneWidget);

      // 3. Ajout favoris
      await tester.tap(find.text('Ajouter aux favoris'));
      await _settle(tester);
      expect(find.text('Retirer des favoris'), findsOneWidget);

      // 4. Ajout watchlist
      await tester.tap(find.text('Ajouter au pannier'));
      await _settle(tester);
      expect(find.text('Retirer du pannier'), findsOneWidget);

      // 5. Retour liste : badge "1" sur l'icône watchlist
      await tester.pageBack();
      await _settle(tester);
      expect(find.text('SérieListe'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);

      // 6. Favoris
      await tester.tap(find.byIcon(Icons.favorite));
      await _settle(tester);
      expect(find.text('Mes favoris'), findsOneWidget);
      expect(find.text('Classic Grey Hooded Sweatshirt'), findsOneWidget);

      // 7. Watchlist
      await tester.pageBack();
      await _settle(tester);
      await tester.tap(find.byIcon(Icons.bookmark));
      await _settle(tester);
      expect(find.text('Ma Watchlist'), findsOneWidget);
      expect(find.text('Classic Grey Hooded Sweatshirt'), findsOneWidget);
    },
  );
}