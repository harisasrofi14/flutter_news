import 'package:dartz/dartz.dart';
import 'package:flutter_news/domain/entities/article_entity.dart';
import 'package:flutter_news/domain/repositories/news_repository.dart';
import 'package:flutter_news/utils/failure.dart';

class GetLocalNews {
  final NewsRepository repository;

  GetLocalNews(this.repository);

  Future<Either<Failure, List<ArticleEntity>>> execute(keyword) {
    return repository.getLocalNews(keyword);
  }
}
