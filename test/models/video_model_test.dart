import 'package:flutter_test/flutter_test.dart';
import 'package:frame/models/video_model.dart';

void main() {
  Map<String, dynamic> videoJson({Object? videoStatus}) => {
    'channelTitle': 'Channel',
    'id': 'video-id',
    'kind': 'youtube#video',
    'defaultThumbnail': 'default.jpg',
    'duration': 'PT1M',
    'description': 'Description',
    'defaultThumbnailWidth': 120,
    'defaultThumbnailHeight': 90,
    'mediumThumbnailWidth': 320,
    'mediumThumbnailHeight': 180,
    'mediumThumbnail': 'medium.jpg',
    'title': 'Title',
    'highThumbnail': 'high.jpg',
    'highThumbnailHeight': 360,
    'highThumbnailWidth': 480,
    'publishedAt': '2026-01-01T00:00:00Z',
    'videoStatus': ?videoStatus,
  };

  test('missing video status defaults to not started', () {
    final video = Video.fromJson(videoJson());

    expect(video.videoStatus, VideoStatus.notStarted);
  });

  test('known video status is restored', () {
    final video = Video.fromJson(
      videoJson(videoStatus: VideoStatus.playing.toString()),
    );

    expect(video.videoStatus, VideoStatus.playing);
  });

  test('unknown video status reports malformed data', () {
    expect(
      () => Video.fromJson(videoJson(videoStatus: 'unknown')),
      throwsA(isA<FormatException>()),
    );
  });
}
