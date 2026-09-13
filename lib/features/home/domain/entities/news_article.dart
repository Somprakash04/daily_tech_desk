import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  const NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.source,
    required this.author,
    required this.publishedAt,
    required this.imageUrl,
    required this.articleUrl,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String source;
  final String author;
  final DateTime publishedAt;
  final String imageUrl;
  final String articleUrl;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'source': source,
      'author': author,
      'publishedAt': publishedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'articleUrl': articleUrl,
    };
  }

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      source: json['source']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
      publishedAt:
      DateTime.tryParse(
        json['publishedAt']?.toString() ?? '',
      ) ??
          DateTime.now(),
      imageUrl: json['imageUrl']?.toString() ?? '',
      articleUrl: json['articleUrl']?.toString() ?? '',
    );
  }

  @override
  List<Object> get props => <Object>[
    id,
    title,
    description,
    category,
    source,
    author,
    publishedAt,
    imageUrl,
    articleUrl,
  ];
}