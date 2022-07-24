import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_news/data/datasource/local_data_source.dart';
import 'package:flutter_news/data/datasource/news_remote_data_source.dart';
import 'package:flutter_news/data/models/article_table.dart';
import 'package:flutter_news/data/models/articles_model.dart';
import 'package:flutter_news/domain/entities/article_entity.dart';
import 'package:flutter_news/domain/repositories/news_repository.dart';
import 'package:flutter_news/utils/exception.dart';
import 'package:flutter_news/utils/failure.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> getNews(
      String keyword, int page, int pageSize) async {
    try {
      final result = await remoteDataSource.getNews(keyword, page, pageSize);
      if (page == 1) {
        localDataSource.deleteNews(keyword: keyword);
        saveNews(result, keyword);
      }
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getLocalNews(
      String keyword) async {
    try {
      var localNews = await localDataSource.getNewsByKeyword(keyword: keyword);
      return Right(localNews.map((model) => model.toEntity()).toList());
    } on DatabaseException {
      return const Left(ConnectionFailure('Failed to load database'));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveNews(List<Articles> article, String keyword) async {
    try {
      for (var value in article) {
        var article = ArticleTable.fromModel(value, keyword);
        await localDataSource.insertNews(article);
      }
    } catch (e) {
      rethrow;
    }
  }
}
