import 'dart:convert';

import 'package:frame/auth/auth_service.dart';
import 'package:http/http.dart';

class VideoProgressService {
  // Save video progress == video_id , user_access_token , video_progress
  final AuthService _authService = AuthService();
  final baseUrl = "https://frame-api-python.fastapicloud.dev";

  void saveVideoProgress({
    required String videoId,
    required double position,
  }) async {
    final token = _authService.getCurrentUserAccessToken();
    if (token == null) {
      throw Exception("User is not authenticated");
    }
    final res = await post(
      Uri.parse("$baseUrl/video-progress"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'video_id': videoId, 'video_progress': position}),
    );
    if (res.statusCode != 200) {
      print(res.toString());
    }
  }
}
