import 'package:article_liste/models/article.dart';

// ── Articles utilisés dans tous les tests ─────────────────────────────────────

final testArticle1 = Article(
  id: 5,
  title: 'Classic Grey Hooded Sweatshirt',
  description: 'Elevate your casual wear with our Classic Grey Hooded Sweatshirt. Made from a soft cotton blend, this hoodie features a front kangaroo pocket, an adjustable drawstring hood, and ribbed cuffs for a snug fit. Perfect for those chilly evenings or lazy weekends, it pairs effortlessly with your favorite jeans or joggers.',
  slug: 'classic-grey-hooded-sweatshirt',
  image: 'https://example.com/bb.jpg',
  price: 79,
  
);

final testArticle2 = Article(
  id: 2,
  title: 'Classic Red Pullover Hoodie',
  description: 'Elevate your casual wardrobe with our Classic Red Pullover Hoodie. Crafted with a soft cotton blend for ultimate comfort, this vibrant red hoodie features a kangaroo pocket, adjustable drawstring hood, and ribbed cuffs for a snug fit. The timeless design ensures easy pairing with jeans or joggers for a relaxed yet stylish look, making it a versatile addition to your everyday attire.',
  slug: 'classic-red-pullover-hoodie',
  image: 'https://example.com/st.jpg',
  price: 10,
);

// ── Réponse JSON simulée de l'API TVMaze ─────────────────────────────────────

final mockArticlesJson = [
  {
    'id': 5,
    'title': 'Classic Grey Hooded Sweatshirt',
    'slug': 'classic-grey-hooded-sweatshirt',
    'images': ['https://example.com/bb.jpg'],
    'description': 'Elevate your casual wear with our Classic Grey Hooded Sweatshirt. Made from a soft cotton blend, this hoodie features a front kangaroo pocket, an adjustable drawstring hood, and ribbed cuffs for a snug fit. Perfect for those chilly evenings or lazy weekends, it pairs effortlessly with your favorite jeans or joggers.',
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
