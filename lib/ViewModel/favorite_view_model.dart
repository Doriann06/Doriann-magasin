import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';

import 'package:doriann_projet/models/article.dart';
import 'package:flutter/material.dart';

class FavoriteViewModel extends ChangeNotifier{
  late List<Article> liste;
  FavoriteViewModel(){
    liste = [];
  }
  void add(Article article){
    liste.add(article);
    notifyListeners();
  }
}
/* void generateFavorites(){
 Array<Article> liste =Article.generateFavorites();
 notifyListeners(); 
}
*/