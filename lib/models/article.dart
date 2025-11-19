import 'package:flutter/material.dart';
class Article {
  int id;
  String title;
  String slug;
  int price;
  String description;
   List<String> tags;
    Color color;

  Article({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.tags,
    required this.color,
  });
  static Article fromJson(Map<String, dynamic> json) {
    final tags =
        (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [];
    return Article(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      price: json['price'],
      description: json['description'],
      tags: tags,
      color: json['color'] != null
          ? Color(int.parse(json['color'], radix: 16))
          : Colors.blueAccent,    
      );
  }
}