import 'package:flutter_news/data/models/article_table.dart';
import 'package:sqflite/sqflite.dart';

class NewsDatabaseHelper {
  static NewsDatabaseHelper? _newsDatabaseHelper;

  NewsDatabaseHelper._instance() {
    _newsDatabaseHelper = this;
  }

  factory NewsDatabaseHelper() =>
      _newsDatabaseHelper ?? NewsDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database = await _initDb();
    return _database;
  }

  static const String _tblNews = 'news';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/news.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblNews (
        title TEXT,
        description TEXT,
        url_to_image TEXT,
        published_at TEXT,
        keyword TEXT
      );
    ''');
  }

  Future<int> insertNews(ArticleTable articleTable) async {
    final db = await database;
    return await db!.insert(_tblNews, articleTable.toJson());
  }

  Future<void> deleteNews(String keyword) async {
    final db = await database;

    await db!.rawQuery("DELETE FROM $_tblNews WHERE keyword = '$keyword'");
  }

  Future<List<Map<String, dynamic>>> getNewsByKeyword(String keyword) async {
    final db = await database;

    final results = await db!
        .rawQuery("SELECT * FROM $_tblNews WHERE keyword = '$keyword'");

    return results;
  }
}
