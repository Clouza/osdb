import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/news.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'news.db');
    debugPrint('Database path: $path');
    
    _database = await _initDB('news.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        link TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        source TEXT NOT NULL,
        sourceIcon TEXT NOT NULL,
        imageUrl TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertFavorite(News news) async {
    final db = await instance.database;
    debugPrint('Inserting favorite: ${news.toMap()}');
    
    try {
      await db.insert(
        'favorites',
        news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('Insert successful');
    } catch (e) {
      debugPrint('Error inserting favorite: $e');
    }
  }

  Future<void> deleteFavorite(String link) async {
    final db = await instance.database;
    await db.delete(
      'favorites',
      where: 'link = ?',
      whereArgs: [link],
    );
  }

  Future<List<News>> getFavorites() async {
    try {
      final db = await instance.database;
      final List<Map<String, dynamic>> maps = await db.query('favorites');
      debugPrint('Loading favorites from DB: $maps');
      return List.generate(maps.length, (i) {
        return News.fromMap(maps[i])..isFavorite = true;
      });
    } catch (e) {
      debugPrint('Error loading favorites: $e');
      return [];
    }
  }
}
