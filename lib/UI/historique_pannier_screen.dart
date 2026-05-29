import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/historique_pannier_provider.dart';

class HistoriquePannierScreen extends StatelessWidget {
  const HistoriquePannierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Historique')),
      body: Consumer<HistoriquePannierProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.items.isEmpty) {
            return const Center(child: Text('Votre historique est vide.'));
          }
          return ListView.builder(
            itemCount: provider.items.length,
            itemBuilder: (context, index) {
              final item = provider.items[index];
              return ListTile(
                title: Text('Pannier n°${item.id}'), // Affiche l'ID du pannier
                subtitle: Text('${item.total}€'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => context.read<HistoriquePannierProvider>().retirerPannier(item.id),
                ),
                onTap: () {
                  // Navigue vers les détails du pannier
                  context.go('/historique-pannier/${item.id}');
                },
                
              );
            },
          );
        },
      ),
    );
  }
}