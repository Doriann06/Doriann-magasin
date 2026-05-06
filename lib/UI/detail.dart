import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:article_liste/providers/favoris_provider.dart';
import 'package:article_liste/providers/pannier_provider.dart';
import '../providers/article_provider.dart';
import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final int articleId;
  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail')),
      body: FutureBuilder<Article>(
        future: context.read<ArticleProvider>().fetchArticleById(articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          final article = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(article.image != null)
                  Center(child: Image.network(article.image!, height: 200,),),
                const SizedBox(height: 16),
                Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
                Text(article.slug),
                if(article.price != null)
                  Text('${article.price!.toStringAsFixed(1)} €'),
                const SizedBox(height: 8),
                Text(article.description),
                const SizedBox(height: 16),
                Consumer<FavorisProvider>(
                  builder: (context, favorisProvider, _) {
                    final estFavori = favorisProvider.estFavori(article.id);
                    return ElevatedButton.icon(
                      onPressed: () => favorisProvider.toggleFavori(article),
                      icon: Icon(estFavori ? Icons.favorite : Icons.favorite_border),
                      label: Text(estFavori ? 'Retirer des favoris' : 'Ajouter aux favoris'),
                    );
                  }
                ),
                Consumer<PannierProvider>(
                  builder: (context, pannierProvider, _) {
                    return ElevatedButton.icon(
                      onPressed: () => pannierProvider.addToPannier(article),
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Ajouter au pannier'),
                    );
                  }
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
