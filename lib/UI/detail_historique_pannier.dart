import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/historique_pannier_provider.dart';
import '../models/pannier.dart';
class DetailHistoriquePannier extends StatelessWidget {
  final int pannierId;
  const DetailHistoriquePannier({super.key, required this.pannierId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pannier')),
      body: FutureBuilder<Pannier?>(
        future: context.read<HistoriquePannierProvider>().getPannierById(pannierId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erreur lors du chargement du pannier'));
          }
          if (snapshot.data == null) {
            return const Center(child: Text('Pannier non trouvé'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.articles.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data!.articles[index];
                    return ListTile(
                      leading: article.image != null
                          ? Image.network(article.image!, width: 50)
                          : const Icon(Icons.tv),
                      title: Text(article.title),
                      subtitle: Text(article.slug),
                      onTap: () => context.push('/article/${article.id}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total : ${snapshot.data!.total.toStringAsFixed(2)} €',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
