import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/music.dart';

class ApiService {
  static const String baseUrl = 'https://osdb.confidence.sh/api';
  static const String apiKey = '5ZEsFGRb9Rs16V5un_v-h';

  Future<List<Music>> fetchMusic() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/music'),
        headers: {'Authorization': 'Bearer $apiKey'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Music.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load music');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}