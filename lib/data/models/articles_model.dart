import 'package:flutter_news/data/models/source_model.dart';
import 'package:flutter_news/domain/entities/article_entity.dart';

class Articles {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Articles(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content']);

  ArticleEntity toEntity() {
    return ArticleEntity(
        title: title ?? "",
        description: description ?? "",
        urlToImage: urlToImage ?? "",
        publishedAt: publishedAt ?? "");
  }
}
