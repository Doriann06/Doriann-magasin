import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:article_liste/models/article.dart';

void main() {
  group('Article', () {
    // JSON complet tel que retourné par l'API
    final jsonComplet = {
      'id': 5,
      'title': 'Classic Grey Hooded Sweatshirt',
      'slug': 'classic-grey-hooded-sweatshirt',
      'description': 'Elevate your casual wear with our Classic Grey Hooded Sweatshirt. Made from a soft cotton blend, this hoodie features a front kangaroo pocket, an adjustable drawstring hood, and ribbed cuffs for a snug fit. Perfect for those chilly evenings or lazy weekends, it pairs effortlessly with your favorite jeans or joggers.',
      'images': ['https://example.com/bb.jpg'],
      'price': 79,
      "category": {
      "id": 1,
      "name": "Clothes",
      "slug": "clothes",
      "image": "https://i.imgur.com/QkIa5tT.jpeg",
      "creationAt": "2026-06-03T19:18:31.000Z",
      "updatedAt": "2026-06-03T19:18:31.000Z"
    },
    };

    test('fromJson crée une Article correctement', () {
      final article = Article.fromJson(jsonComplet);

      expect(article.id, 5);
      expect(article.title, 'Classic Grey Hooded Sweatshirt');// TODO : vérifier que le title est correctement extrait du champ "name"
      expect(article.slug, 'classic-grey-hooded-sweatshirt');// TODO : vérifier que le slug est correctement extrait du champ "slugs"
      expect(article.description, 'Elevate your casual wear with our Classic Grey Hooded Sweatshirt. Made from a soft cotton blend, this hoodie features a front kangaroo pocket, an adjustable drawstring hood, and ribbed cuffs for a snug fit. Perfect for those chilly evenings or lazy weekends, it pairs effortlessly with your favorite jeans or joggers.');// TODO : vérifier que les champs de la série sont correctement initialisés à partir du JSON
      expect(article.price, 79);// TODO : vérifier que la note est correctement extraite du champ "rating"
      expect(article.image, 'https://example.com/bb.jpg');// TODO : vérifier que les champs de la série sont correctement initialisés à partir du JSON
      expect(article.category!['name'], 'Clothes');// TODO : vérifier que la catégorie est correctement extraite du champ "category"
    });


    test('fromJson gère les champs optionnels absents', () {
      final jsonMinimal = {'id': 2, 'title': 'Test'};
      final article = Article.fromJson(jsonMinimal);

      expect(article.slug, 'Inconnu');// TODO : vérifier que le slug est "Inconnu"
      expect(article.description, '');// TODO : vérifier que le description est une chaîne vide
    });

    test('toJson / fromJson sont symétriques', () {
      final original = Article.fromJson(jsonComplet);

      final reconstruite = Article.fromJson(original.toJson());
      expect(reconstruite.id, original.id);  // TODO : vérifier que l'article reconstruit a le même id que original
      expect(reconstruite.title, original.title);  // TODO : vérifier que l'article reconstruit a le même title que original
      expect(reconstruite.price, original.price);  // TODO : vérifier que l'article reconstruit a le même prix que original
    });
  });
}
