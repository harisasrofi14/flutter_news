import 'package:dartz/dartz.dart';
import 'package:flutter_news/domain/entities/article_entity.dart';
import 'package:flutter_news/utils/failure.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<ArticleEntity>>> getNews(
      String keyword, int page, int pageSize);

  Future<Either<Failure, List<ArticleEntity>>> getLocalNews(String keyword);
}
