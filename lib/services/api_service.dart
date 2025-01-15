import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/news.dart';

class ApiService {
  static const String baseUrl = 'https://ok.surf/api/v1';

  Future<List<News>> fetchNews() async {
    try {
      final httpClient = HttpClient()
        ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      final request = await httpClient.getUrl(Uri.parse('$baseUrl/news-feed'));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> data = json.decode(responseBody);
        List<News> allNews = [];

        // Mengambil berita dari setiap kategori
        data.forEach((category, newsList) {
          if (newsList is List) {
            allNews.addAll(
              newsList.map((newsItem) => News.fromJson(newsItem)).toList()
            );
          }
        });

        return allNews;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}