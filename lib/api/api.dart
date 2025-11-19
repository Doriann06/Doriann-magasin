import 'dart:convert';
import '../models/article.dart';
import 'package:http/http.dart' as http;

class API {
  
  static Future<List<Article>> getArticles() async {
    final String apiUrl = "https://api.escuelajs.co/api/v1/products";
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Article> articles = jsonData.map((item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception("Erreur lors du chargement des données");
    }
  }
}
  