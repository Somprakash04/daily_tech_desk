class ArticleModel {
  final int id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? author;
  final String sourceName;
  final String articleUrl;
  final DateTime publishedAt;
  final String category;
  final int readingTimeMinutes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ArticleModel({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.author,
    required this.sourceName,
    required this.articleUrl,
    required this.publishedAt,
    required this.category,
    required this.readingTimeMinutes,
    this.createdAt,
    this.updatedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      imageUrl: json['imageUrl'],
      author: json['author'],
      sourceName: json['sourceName'] ?? '',
      articleUrl: json['articleUrl'] ?? '',
      publishedAt: DateTime.parse(
        json['publishedAt'],
      ),
      category: json['category'] ?? '',
      readingTimeMinutes:
      json['readingTimeMinutes'] ?? 1,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}