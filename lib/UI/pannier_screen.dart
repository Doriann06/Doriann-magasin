import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/pannier_provider.dart';
import '../providers/historique_pannier_provider.dart';
import '../models/pannier.dart';
class PannierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pannier')),
      body: Consumer<PannierProvider>(
        builder: (context, provider, _) {
          if (provider.pannier.isEmpty) {
            return const Center(child: Text('Votre pannier est vide'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.pannier.length,
                  itemBuilder: (context, index) {
                    final article = provider.pannier[index];
                    return ListTile(
                      leading: article.image != null
                          ? Image.network(article.image!, width: 50)
                          : const Icon(Icons.tv),
                      title: Text(article.title),
                      subtitle: Text(article.slug),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => context.read<PannierProvider>().removeFromPannier(index),
                      ),
                      onTap: () => context.push('/article/${article.id}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total : ${provider.total.toStringAsFixed(2)} €',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Pannier pannier = Pannier(id: DateTime.now().millisecondsSinceEpoch, articles: provider.pannier, total: provider.total);
                  context.read<HistoriquePannierProvider>().ajouterAPannier(pannier);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pannier enregistré dans l\'historique')),
                  );
                  },
                  child: const Text('Valider le pannier')
                ),
            ],
          );
        },
      ),
    );
  }
}
