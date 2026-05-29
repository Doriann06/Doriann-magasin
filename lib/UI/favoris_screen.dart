import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/favoris_provider.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Favoris')),
      body: Consumer<FavorisProvider>(
        builder: (context, provider, _) {
          if (provider.favoris.isEmpty) {
            return const Center(child: Text('Aucun favori pour l\'instant'));
          }
          return ListView.builder(
            itemCount: provider.favoris.length,
            itemBuilder: (context, index) {
              final article = provider.favoris[index];
              return ListTile(
                leading: article.image != null
                    ? Image.network(article.image!, width: 50)
                    : const Icon(Icons.tv),
                title: Text(article.title),
                subtitle: Text(article.slug),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => context.read<FavorisProvider>().toggleFavori(article),
                ),
                onTap: () => context.push('/article/${article.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
