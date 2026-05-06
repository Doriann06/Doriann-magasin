import 'package:flutter/material.dart';
import '../models/article.dart';

class PannierProvider with ChangeNotifier {
  List<Article> _pannier = [];
  List<Article> get pannier => _pannier;
  Future<void> addToPannier(Article article) async {
    _pannier.add(article);
    notifyListeners();
  }
  Future<void> removeFromPannier(int position) async {
    _pannier.removeAt(position);
    notifyListeners();
  }
  Future<void> clearPannier() async {
    _pannier.clear();
    notifyListeners();
  }
  double get total => _pannier.fold(0, (sum, a) => sum + (a.price ?? 0));
}