import 'dart:convert';

import 'package:frame/models/channel_model.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/models/playlist_model.dart';
import 'package:frame/models/video_model.dart';
import 'package:http/http.dart';
import 'package:frame/search/response.dart';

enum SearchType { video, channel, playlist }

class SearchService {
  final baseUrl = 'frame-api-python.fastapicloud.dev';
  final rootUrl = '/search';

  Future<Response_> searchByWord(
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
      return Response_(
        message: "Search request failed with status ${response.statusCode}",
        success: false,
      );
    }

    final decoded = jsonDecode(response.body)['results'];
    if (decoded is! List) {
      return Response_(
        message: "Search response is not a list",
        success: false,
      );
    }

    return Response_(
      data: _convertDataIntoModels(
        decoded.map((item) => Map<String, dynamic>.from(item as Map)).toList(),
      ),
      success: true,
    );
  }

  List<Content> _convertDataIntoModels(List<Map<String, dynamic>> jsonData) {
    final List<Content> converted = <Content>[];
    for (final content in jsonData) {
      final kind = content["kind"];
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

  Future<Response_> searchById(String id) async {
    final queryParameters = {'id': id};

    final uri = Uri.https(baseUrl, rootUrl, queryParameters);

    final response = await get(uri);

    if (response.statusCode != 200) {
      return Response_(
        message: "Search request failed with status ${response.statusCode}",
        success: false,
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData is! Map || responseData['result'] is! Map) {
      return Response_(
        message: "Search response result is invalid",
        success: false,
      );
    }

    final decoded = Map<String, dynamic>.from(responseData['result'] as Map);

    final results = _convertDataIntoModels([decoded]);

    if (results.isEmpty) {
      return Response_(message: "Content not found", success: false);
    }

    return Response_(data: results.first, success: true);
  }
}
