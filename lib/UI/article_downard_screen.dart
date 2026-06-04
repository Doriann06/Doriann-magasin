import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/article_provider.dart';

class ArticleListDownwardScreen extends StatefulWidget {
  const ArticleListDownwardScreen({super.key});

  @override
  State<ArticleListDownwardScreen> createState() => _ArticleListDownwardScreenState();
}

class _ArticleListDownwardScreenState extends State<ArticleListDownwardScreen> {
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
        title: const Text('ArticleListeDecroissant'),
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
              icon: const Icon(Icons.arrow_upward),
              onPressed: () => context.go('/article-upward'),
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
              article.sortByPriceDownward(provider.articles); // Tri par ordre decroissant du prix
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
