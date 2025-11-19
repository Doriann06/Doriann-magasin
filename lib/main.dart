import 'package:flutter/material.dart';
import 'UI/mytheme.dart';
import 'UI/home.dart';

void main() {
  runApp(MyProjetApp());
}

class MyProjetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.dark();
    return MaterialApp(theme: theme, title: 'Projet magasin Doriann', home: Home());
  }
}