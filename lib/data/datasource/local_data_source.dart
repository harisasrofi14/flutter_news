import 'package:flutter_news/data/datasource/db/news_database_helper.dart';
import 'package:flutter_news/data/models/article_table.dart';

abstract class NewsLocalDataSource {
  Future<String> insertNews(ArticleTable articleTable);

  Future<void> deleteNews({keyword = ''});

  Future<List<ArticleTable>> getNewsByKeyword({keyword = ''});
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final NewsDatabaseHelper databaseHelper;

  NewsLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<ArticleTable>> getNewsByKeyword({keyword = ''}) async {
    try {
      final result = await databaseHelper.getNewsByKeyword(keyword);
      return result.map((data) => ArticleTable.fromMap(data)).toList();
    } catch (e) {
      rethrow;
      //throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertNews(ArticleTable articleTable) async {
    try {
      await databaseHelper.insertNews(articleTable);
      return 'Success';
    } catch (e) {
      rethrow;
      //throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> deleteNews({keyword = ''}) async {
    try {
      await databaseHelper.deleteNews(keyword);
    } catch (e) {
      rethrow;
    }
  }
}
