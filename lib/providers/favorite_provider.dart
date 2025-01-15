import 'package:flutter/foundation.dart';
import '../models/news.dart';
import '../services/database_helper.dart';

class FavoriteProvider with ChangeNotifier {
  final List<News> _favorites = [];
  List<News> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final favs = await DatabaseHelper.instance.getFavorites();
    _favorites.clear();
    _favorites.addAll(favs);
    notifyListeners();
  }

  Future<void> toggleFavorite(News news) async {
    final isExist = _favorites.any((element) => element.link == news.link);
    if (isExist) {
      await DatabaseHelper.instance.deleteFavorite(news.link);
      _favorites.removeWhere((element) => element.link == news.link);
    } else {
      await DatabaseHelper.instance.insertFavorite(news);
      _favorites.add(news..isFavorite = true);
    }
    notifyListeners();
  }

  bool isFavorite(String link) {
    return _favorites.any((element) => element.link == link);
  }
}