import 'dart:convert';

import 'package:frame/models/channel_model.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/models/playlist_model.dart';
import 'package:frame/models/video_model.dart';
import 'package:http/http.dart';

enum SearchType { video, channel, playlist }

class SearchService {
  Future<List<Content>> searchByWord(
    String query, {
    SearchType? type,
    int? maxResults,
  }) async {
    final queryParameters = {
      'q': query,
      if (type != null) 'type': type.name,
      if (maxResults != null) 'maxResults': maxResults.toString(),
    };

    final uri = Uri.https(
      'frame-api.fly.dev',
      '/api/v1/search',
      queryParameters,
    );

    final response = await get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        "Search request failed with status ${response.statusCode}",
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw const FormatException("Search response is not a list");
    }

    return _convertDataIntoModels(
      decoded.map((item) => Map<String, dynamic>.from(item as Map)).toList(),
    );
  }

  List<Content> _convertDataIntoModels(List<Map<String, dynamic>> jsonData) {
    final converted = <Content>[];

    for (final content in jsonData) {
      final kind = content['kind'];

      if (kind == 'youtube#video') {
        converted.add(Video.fromJson(content));
      } else if (kind == 'youtube#playlist') {
        converted.add(Playlist.fromJson(content));
      } else if (kind == 'youtube#channel') {
        converted.add(Channel.fromJson(content));
      }
    }

    return converted;
  }

  Future<Content> searchById(String id) async {
    final queryParameters = {"id": id};

    final uri = Uri.https(
      'frame-api.fly.dev',
      '/api/v1/search',
      queryParameters,
    );

    final response = await get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        "Search request failed with status ${response.statusCode}",
      );
    }

    final decoded = jsonDecode(response.body);

    final results = _convertDataIntoModels([decoded]);

    if (results.isEmpty) {
      throw const FormatException("Content not found");
    }

    return results.first;
  }
}

void main() async {
  SearchService searchService = SearchService();

  print(
    await searchService.searchByWord(
      "query",
      type: SearchType.playlist,
      maxResults: 100,
    ),
  );
}
