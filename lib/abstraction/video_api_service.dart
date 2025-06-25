import 'dart:convert';
import 'dart:io';

import 'package:vd/models/video_model.dart';

class VideoApiService {
  static const String baseUrl = 'pixabay.com';
  static const String apiKey =  //your api key

  static Future<List<Video>> fetchVideos({
    String query = 'nature',
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final client = HttpClient();
      final uri = Uri.https(baseUrl, '/api/videos/', {
        'key': apiKey,
        'q': query,
        'page': page.toString(),
        'per_page': perPage.toString(),
        'safesearch': 'true',
      });

      print('Fetching videos from: $uri');

      final request = await client.getUrl(uri);
      request.headers.set(HttpHeaders.userAgentHeader, 'FlutterApp/1.0');
      final response = await request.close();
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        print('Response status: ${response.statusCode}');
        final data = json.decode(responseBody);
        final List<dynamic> videosJson = data['hits'] ?? [];
        print('Parsed ${videosJson.length} videos');
        client.close();
        return videosJson.map((json) => Video.fromJson(json)).toList();
      } else {
        client.close();
        return [];
      }
    } catch (e) {
      print('Error fetching videos: $e');
      return [];
    }
  }
}
