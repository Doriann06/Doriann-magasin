import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:article_liste/models/pannier.dart';

void main() {
  group('Pannier', () {
    // JSON complet tel que retourné par l'API
    final jsonComplet = {
      'articles': [
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
      ],
    };
      

    test('fromJson crée une Pannier correctement', () {
      final pannier = Pannier.fromJson(jsonComplet);

      expect(pannier.articles.length, 2);
      expect(pannier.total, 89);
    });



    test('toJson / fromJson sont symétriques', () {
      final original = Pannier.fromJson(jsonComplet);

      final reconstruite = Pannier.fromJson(original.toJson());
      expect(reconstruite.articles.length, original.articles.length);
      expect(reconstruite.total, original.total);
    });
  });
}
