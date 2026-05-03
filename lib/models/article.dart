class Article {
  final int id;
  final String title;
  final String description;
  final String slug;
  final String? image;
  final int? price;
 

   Article({
    required this.id,
    required this.title,
    required this.description,
    required this.slug,
    this.image,
    this.price,
    
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String? ?? json['title'] as String? ?? 'Sans titre',
      description: json['description'] !=null
        ?json['description'] as String  
        :json['description'] as String? ?? '',
      slug: json['slug'] !=null
        ?json['slug'] as String  
        :json['slug'] as String? ?? 'Inconnu',
      image: json['images'][0] as String? ?? json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );
  }
  Map<String, dynamic> toJson() =>{
      'id': id,
      'title': title,
      'description': description,
      'slug': slug,
      'images': [image],
      'price': price,
  };
  @override
  bool operator ==(Object other) => other is Article &&other.id == id ;
  @override
  int get hashCode => id.hashCode;
}