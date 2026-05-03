import 'package:flutter_test/flutter_test.dart';
import 'package:article_liste/services/api.dart';
import '../../helpers/test_data.dart';
import '../../mocks/mock_http_client.dart';

void main() {
  group('ArticleApiService', () {
    test('fetchArticles retourne une liste de Articles en cas de succès', () async {
      final service=ArticleApiService(client: MockHttpClient(body:mockArticlesJson));
      final articles = await service.fetchArticles();
      expect(articles.length, 2);// TODO : vérifier que la liste contient 2 articles
      expect(articles[0].title, 'Classic Grey Hooded Sweatshirt');
      expect(articles[1].title, 'Classic Red Pullover Hoodie');
    });
    test('fetchArticles lève une exception si le statut est 500', () async {
      final service=ArticleApiService(client: MockHttpClient(statusCode:500,body: ''),);
      expect(() => service.fetchArticles(), throwsException);
    });
    test('fetchArticleById retourne le bon article', () async {
      final service=ArticleApiService(client: MockHttpClient(body:mockArticlesJson[0]),);
      final article = await service.fetchArticleById(5);
      expect(article.id, 5);
      expect(article.title, 'Classic Grey Hooded Sweatshirt');
    });
  test('getMockArticles retourne une liste non vide', () {
      final service=ArticleApiService();
      expect(service.getMockArticles(), isNotEmpty);// TODO : vérifier que getMockArticles retourne une liste non vide
    });
  });
}