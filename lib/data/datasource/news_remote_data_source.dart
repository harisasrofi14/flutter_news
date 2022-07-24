import 'dart:convert';

import 'package:flutter_news/data/models/articles_model.dart';
import 'package:flutter_news/data/models/news_response.dart';
import 'package:flutter_news/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  Future<List<Articles>> getNews(String keyword, int page, int pageSize);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  static const API_KEY = 'fc22459820e345e5a60df4e02327e520';
  static const BASE_URL = 'https://newsapi.org/v2/everything';

  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Articles>> getNews(String keyword, int page, int pageSize) async {
    final response = await client.get(Uri.parse(
        '$BASE_URL?q=$keyword&page=$page&pagesize=$pageSize&apiKey=$API_KEY'));

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(json.decode(response.body)).articles;
    } else {
      throw ServerException();
    }
  }
}
