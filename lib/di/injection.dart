import 'package:flutter_news/data/datasource/db/news_database_helper.dart';
import 'package:flutter_news/data/datasource/local_data_source.dart';
import 'package:flutter_news/data/datasource/news_remote_data_source.dart';
import 'package:flutter_news/data/repositories/news_repository_impl.dart';
import 'package:flutter_news/domain/repositories/news_repository.dart';
import 'package:flutter_news/domain/usecases/get_local_news.dart';
import 'package:flutter_news/domain/usecases/get_news.dart';
import 'package:flutter_news/presentation/bloc/news/news_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
      () => NewsBloc(getNews: locator(), getLocalNews: locator()));

  locator.registerLazySingleton(() => GetNews(locator()));

  locator.registerLazySingleton(() => GetLocalNews(locator()));

  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));

  locator.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<NewsDatabaseHelper>(() => NewsDatabaseHelper());
  locator.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton(() => http.Client());
}
