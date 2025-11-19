import 'package:flutter/material.dart';

import '../models/article.dart';

class Detail extends StatelessWidget {
  final Article article;

  const Detail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article ${article.title} detail')),
      body: Center(
        child: Column(
          children: [
            Card(
              color: article.color,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: Image.network(
                article.image,
                width: 200,
                height: 200,
                )
            ),
            Card(
              color: article.color,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.key)),
                title: const Text('Identifiant'),
                subtitle: Text('${article.id}'),
              ),
            ),
            Card(
              color: article.color,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.title)),
                title: const Text("Titre de l'article "),
                subtitle: Text(article.title),
              ),
            ),
            Card(
              color: article.color,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.description)),
                title: const Text('label de l\'article'),
                subtitle: Text(article.slug),
              ),
            ),
             Card(
              color: article.color,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.description)),
                title: const Text('prix de l\'article'),
                subtitle: Text('${article.price}'),
              ),
            ),
             Card(
              color: article.color,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: (const Icon(Icons.description)),
                title: const Text('description de l\'article'),
                subtitle: Text(article.description),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}