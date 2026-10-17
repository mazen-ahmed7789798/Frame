import 'dart:convert';

import 'package:frame/auth/auth_service.dart';
import 'package:frame/models/channel_model.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/models/playlist_model.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/search/response.dart';
import 'package:http/http.dart';

enum SearchType { video, channel, playlist }

class SearchService {
  // السيرفر المرفوع (للنشر)
  static const _remoteHost = 'frame-api-python.fastapicloud.dev';
  static const _rootUrl = '/search';

  final authService = AuthService();

  Future<Response_> searchByWord(
    String query, {
    SearchType? type,
    int? maxResults,
  }) async {
    try {
      final token = authService.getCurrentUserAccessToken();

      final queryParameters = {
        'query': query,
        if (type != null) 'type': type.name,
        if (maxResults != null) 'max_results': maxResults.toString(),
      };

      final uri = Uri.https(_remoteHost, _rootUrl, queryParameters);

      final response = await get(
        uri,
        headers: {if (token != null) 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        return Response_(
          message: 'Search request failed with status ${response.statusCode}',
          success: false,
        );
      }

      final responseBody = jsonDecode(response.body);

      if (responseBody is! Map || responseBody['results'] is! List) {
        return Response_(
          message: 'Search response is not a list',
          success: false,
        );
      }

      final decoded = responseBody['results'] as List;
    
      final results = _convertDataIntoModels(
        decoded.map((item) => Map<String, dynamic>.from(item as Map)).toList(),
      );

      return Response_(data: results, success: true);
    } catch (error) {
      return Response_(message: 'Search failed: $error', success: false);
    }
  }

  List<Content> _convertDataIntoModels(List<Map<String, dynamic>> jsonData) {
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

    return converted;
  }

  Future<Response_> searchById(String id) async {
    final stopwatch = Stopwatch()..start();

    try {
      final token = authService.getCurrentUserAccessToken();
      final uri = Uri.https(_remoteHost, _rootUrl, {'id': id});
      final response = await get(
        uri,
        headers: {if (token != null) 'Authorization': "Bearer $token"},
      );

      if (response.statusCode != 200) {
        return Response_(
          message: 'Search request failed with status ${response.statusCode}',
          success: false,
        );
      }

      final responseData = jsonDecode(response.body);

      if (responseData is! Map || responseData['result'] is! Map) {
        return Response_(
          message: 'Search response result is invalid',
          success: false,
        );
      }

      final decoded = Map<String, dynamic>.from(responseData['result'] as Map);
      final results = _convertDataIntoModels([decoded]);

      if (results.isEmpty) {
        return Response_(message: 'Content not found', success: false);
      }

      return Response_(data: results.first, success: true);
    } catch (error) {
      return Response_(message: 'Search failed: $error', success: false);
    } finally {
      stopwatch.stop();
    }
  }
}
