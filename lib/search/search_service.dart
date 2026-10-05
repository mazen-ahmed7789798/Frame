import 'dart:convert';

import 'package:frame/models/channel_model.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/models/playlist_model.dart';
import 'package:frame/models/video_model.dart';
import 'package:http/http.dart' hide Response;
import 'package:frame/search/response.dart';

enum SearchType { video, channel, playlist }

class SearchService {
  final baseUrl = 'https://frame-api-python.fastapicloud.dev';
  final rootUrl = '/search';
  Future<Response> searchByWord(
    String query, {
    SearchType? type,
    int? maxResults,
  }) async {
    final queryParameters = {
      'query': query,
      if (type != null) 'type': type.name,
      if (maxResults != null) 'max_results': maxResults.toString(),
    };

    final uri = Uri.https(baseUrl, rootUrl, queryParameters);

    final response = await get(uri);

    if (response.statusCode != 200) {
      return Response(
        message: "Search request failed with status ${response.statusCode}",
        success: false,
      ).data;
    }

    final decoded = jsonDecode(response.body)['results'];
    if (decoded is! List) {
      return Response(
        message: "Search response is not a list",
        success: false,
      ).data;
    }

    return Response(
      data: _convertDataIntoModels(
        decoded.map((item) => Map<String, dynamic>.from(item as Map)).toList(),
      ).data,
      success: true,
    );
  }

  Response _convertDataIntoModels(List<Map<String, dynamic>> jsonData) {
    final List<Content> converted = <Content>[];

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

    return Response(data: converted, success: true).data;
  }

  Future<Response> searchById(String id) async {
    final queryParameters = {'id': id};

    final uri = Uri.https(baseUrl, rootUrl, queryParameters);

    final response = await get(uri);

    if (response.statusCode != 200) {
      return Response(
        message: "Search request failed with status ${response.statusCode}",
        success: false,
      ).data;
    }

    final responseData = jsonDecode(response.body);

    if (responseData is! Map || responseData['result'] is! Map) {
      return Response(
        message: "Search response result is invalid",
        success: false,
      ).data;
    }

    final decoded = responseData['result'] as Map;

    final results = _convertDataIntoModels([
      Map<String, dynamic>.from(decoded),
    ]);

    if (results.data.isEmpty) {
      return Response(
        message: "Content not found",
        success: false,
      );
    }

    return results;
  }
}
