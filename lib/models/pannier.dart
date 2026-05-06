import 'article.dart';
class Pannier {
  final List<Article> articles;
  final int total;
  Pannier({
    required this.articles,
    required this.total,
  });
  Map<String, dynamic> toJson() => {
    'articles': articles.map((a) => a.toJson()).toList(),
  };
  factory Pannier.fromJson(Map<String, dynamic> json) {
    final articles = (json['articles'] as List)
        .map((a) => Article.fromJson(a))
        .toList();
    final total = articles.fold(0, (sum, a) => sum + (a.price ?? 0));
    return Pannier( articles: articles, total: total);
  }
}