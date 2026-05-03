import 'dart:convert';
import '../models/article.dart';
import 'package:http/http.dart' as http;

class ArticleApiService {
  
  static const _baseUrl = 'https://api.escuelajs.co/api/v1/products';
  static const _timeout = Duration(seconds: 10);
  final http.Client _client;
  // Le client HTTP est injecté — par défaut http.Client() en production.
  // En test, on injecte un MockHttpClie
  ArticleApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Article>> fetchArticles({int page=0}) async {
    final uri = Uri.parse(_baseUrl);
    final response = await _client.get(uri).timeout(_timeout);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((j) => Article.fromJson(j)).toList();
    } 
    throw Exception('Erreur HTTP ${response.statusCode}');
  }
  Future<Article> fetchArticleById(int id) async {
    final uri = Uri.parse('$_baseUrl/$id');
    final response = await _client.get(uri).timeout(_timeout);

    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body));
    } 
    throw Exception('Série $id introuvable');
  }
  /// Données de secours affichées si le réseau est indisponible.
  List<Article> getMockArticles() => [
    Article(id: 0, title: 'Mode hors-ligne', slug: 'Pas de connexion réseau', price: 0, description: '_',image: null ),
  ];
}
  