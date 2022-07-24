import 'package:flutter_news/data/models/articles_model.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<Articles> articles;

  NewsResponse(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: List<Articles>.from((json['articles'] as List)
            .map((e) => Articles.fromJson(e))
            .where((element) => element.title != null)),
      );
}
