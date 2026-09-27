import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sf/track_model.dart';

class AudisApi {
  static const String baseUrl = "https://api.audius.co/v1";

  Future<List<TrackModel>> getTrendingTracks() async {
    log("Get trending songs called");
    final url = Uri.parse('$baseUrl/tracks/trending?limit=20');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Faild to fetch trending tracks: ${response.statusCode}");
    }

    final Map<String, dynamic> json = jsonDecode(response.body);
    final List data = json['data'] ?? [];

    return data.map((track) => TrackModel.fromjson(track)).toList();
  }

  Future<List<TrackModel>> searchTracks(String query) async {
    log("Searching songs called");

    final url = Uri.parse('$baseUrl/tracks/search')
        .replace(queryParameters: {'query': query, 'limit': '20'});

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to search songs :${response.statusCode}");
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    final List data = json['data'] ?? [];

    return data.map((track) => TrackModel.fromjson(track)).toList();
  }
}
