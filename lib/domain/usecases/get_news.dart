import 'package:dartz/dartz.dart';
import 'package:flutter_news/domain/entities/article_entity.dart';
import 'package:flutter_news/domain/repositories/news_repository.dart';
import 'package:flutter_news/utils/failure.dart';

class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<Either<Failure, List<ArticleEntity>>> execute(
      keyword, page, pageSize) {
    return repository.getNews(keyword, page, pageSize);
  }
}
