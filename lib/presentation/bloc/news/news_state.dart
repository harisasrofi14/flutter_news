import 'package:flutter_news/domain/entities/article_entity.dart';

abstract class NewsState {
  const NewsState();
}

class NewsInitialState extends NewsState {}

class NewsEmpty extends NewsState {}

class NewsLoading extends NewsState {}

class NewsError extends NewsState {}

class NewsHasData extends NewsState {
  final List<ArticleEntity> result;

  const NewsHasData(this.result);
}

class NewsHasLocalData extends NewsState {
  final List<ArticleEntity> result;

  const NewsHasLocalData(this.result);
}

class NewsEmptyData extends NewsState {}
