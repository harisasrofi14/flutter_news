import 'package:flutter_news/domain/entities/article_entity.dart';

import 'articles_model.dart';

class ArticleTable {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;
  final String? keyword;

  const ArticleTable(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.publishedAt,
      required this.keyword});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'url_to_image': urlToImage,
        'published_at': publishedAt,
        'keyword': keyword
      };

  factory ArticleTable.fromMap(Map<String, dynamic> map) => ArticleTable(
      title: map['title'],
      description: map['description'],
      urlToImage: map['url_to_image'],
      publishedAt: map['published_at'],
      keyword: 'keyword');

  factory ArticleTable.fromModel(Articles articles, String keyword) {
    return ArticleTable(
        title: articles.title,
        description: articles.description,
        urlToImage: articles.urlToImage,
        publishedAt: articles.publishedAt,
        keyword: keyword);
  }

  ArticleEntity toEntity() {
    return ArticleEntity(
        title: title ?? "",
        description: description ?? "",
        urlToImage: urlToImage ?? "",
        publishedAt: publishedAt ?? "");
  }
}
