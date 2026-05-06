import 'package:go_router/go_router.dart';
import 'UI/card1.dart';
import 'UI/card2.dart';
import 'UI/pannier_screen.dart';
import 'UI/detail.dart';
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ArticleListScreen(),
      routes: [
        GoRoute(
          path: 'article/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return ArticleDetailScreen(articleId: id);
          },
        ),
        GoRoute(
          path: 'favoris',
          builder: (context, state) => const FavorisScreen(),
        ),
        GoRoute(
          path: 'pannier',
          builder: (context, state) =>  PannierScreen(),
        ),
      ],
    ),
  ],
);
