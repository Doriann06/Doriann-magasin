import 'article.dart';
class Pannier {
  final int id;
  final List<Article> articles;
  final double total;
  Pannier({
    required this.id,
    required this.articles,
    required this.total,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'articles': articles.map((a) => a.toJson()).toList(),
  };
  factory Pannier.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final articles = (json['articles'] as List)
        .map((a) => Article.fromJson(a))
        .toList();
    final total = articles.fold(0.0, (double sum, Article a) => sum + (a.price ?? 0));
    return Pannier( id: id, articles: articles, total: total);
  }
}