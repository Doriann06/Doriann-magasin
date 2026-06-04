import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/article_provider.dart';

class ArticleListUpwardScreen extends StatefulWidget {
  const ArticleListUpwardScreen({super.key});

  @override
  State<ArticleListUpwardScreen> createState() => _ArticleListUpwardScreenState();
}

class _ArticleListUpwardScreenState extends State<ArticleListUpwardScreen> {
  @override
  void initState() {
    super.initState();
    // Déclenche le changement après la construction du premier frame 
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleProvider>().fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArticleListeCroissant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.go('/favoris'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.go('/pannier'),
          ),
          IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => context.go('/historique-pannier'),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () => context.go('/article-downward'),
            ),
        ],  
      ),
      body: Consumer<ArticleProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }
          return ListView.builder(
            itemCount: provider.articles.length,
            itemBuilder: (context, index) {
              final article = provider.articles[index];
              article.sortByPriceUpward(provider.articles); // Tri par ordre croissant du prix
              return ListTile(
                leading: article.image != null
                    ? Image.network(article.image!, width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.tv),
                title: Text(article.title),
                subtitle: Text(' ${article.slug}'),
                trailing: article.price != null 
                  ? Text('${article.price},€') 
                  : null,
                onTap: () => context.go('/article/${article.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
