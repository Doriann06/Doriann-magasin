import 'package:go_router/go_router.dart';
import 'UI/article_screen.dart';
import 'UI/favoris_screen.dart';
import 'UI/pannier_screen.dart';
import 'UI/detail.dart';
import 'UI/historique_pannier_screen.dart';
import 'UI/detail_historique_pannier.dart';
import 'UI/article_downard_screen.dart';
import 'UI/article_upward_screen.dart';
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
        GoRoute(
          path: 'historique-pannier',
          builder: (context, state) => const HistoriquePannierScreen(),
        ),
        GoRoute(
          path: 'historique-pannier/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return DetailHistoriquePannier(pannierId: id);
          },
        ),
        GoRoute(
          path: 'article-downward',
          builder: (context, state) => const ArticleListDownwardScreen(),
        ),
        GoRoute(
          path: 'article-upward',
          builder: (context, state) => const ArticleListUpwardScreen(),
        ),
      ],
    ),
  ],
);
