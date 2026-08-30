import 'package:frame/models/content_model.dart';

class Video implements Content {
  late dynamic _vidoeDuration;

  late String _description;

  late int _defaultThumbnailwidth;
  late int _defaultThumbnailHeight;

  late int _mediumThumbnailWidth;
  late int _mediumThumbnailHeight;

  late int _highThumbnailHeight;
  late int _highThumbnailWidth;

  late String _channelTitle;

  @override
  late String _contentId;

  @override
  late String _contentType;

  @override
  late String _defaultThumbnail;

  @override
  late String _highThumbnail;

  @override
  late String _mediumThumbnail;

  @override
  late DateTime _publishedAt;

  @override
  late String _contentTitle;

  Video(
    this._channelTitle,
    this._contentId,
    this._contentType,
    this._defaultThumbnail,
    this._vidoeDuration,
    this._description,
    this._defaultThumbnailwidth,
    this._defaultThumbnailHeight,
    this._mediumThumbnailWidth,
    this._mediumThumbnailHeight,
    this._mediumThumbnail,
    this._contentTitle,
    this._highThumbnail,
    this._highThumbnailHeight,
    this._highThumbnailWidth,
    this._publishedAt,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": _contentId,
      "duration": _vidoeDuration,
      "title": _contentTitle,
      "type": _contentType,
      "publishedAt": _publishedAt.toIso8601String(),
      "mediumThumbnail": _mediumThumbnail,
      "highThumbnail": _highThumbnail,
      "defaultThumbnail": _defaultThumbnail,
      "channelTitle": _channelTitle,
      "highThumbnailWidth": _highThumbnailWidth,
      "highThumbnailHeight": _highThumbnailHeight,
      "mediumThumbnailWidth": _mediumThumbnailWidth,
      "mediumThumbnailHeight": _mediumThumbnailHeight,
      "defaultThumbnailHeight": _defaultThumbnailHeight,
      "defaultThumbnailWidth": _defaultThumbnailwidth,
      "description": _description,
    };
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      json["channelTitle"],
      json["id"],
      json["kind"],
      json["defaultThumbnail"],
      json["duration"],
      json["description"],
      json["defaultThumbnailWidth"],
      json["defaultThumbnailHeight"],
      json["mediumThumbnailWidth"],
      json["mediumThumbnailHeight"],
      json["mediumThumbnail"],
      json["title"],
      json["highThumbnail"],
      json["highThumbnailHeight"],
      json["highThumbnailWidth"],
      DateTime.parse(json["publishedAt"]),
    );
  }

  String get videoId => _contentId;

  String get videoDuration => _vidoeDuration;

  String get videoTitle => _contentTitle;

  String get videoDescription => _description;

  int get defaultThumbnailWidth => _defaultThumbnailwidth;

  int get defaultThumbnailHeight => _defaultThumbnailHeight;

  int get mediumThumbnailHeight => _mediumThumbnailHeight;

  int get mediumThumbnailWidth => _mediumThumbnailWidth;

  int get highThumbnailWidth => _highThumbnailWidth;

  int get highThumbnailHeight => _highThumbnailHeight;

  String get channelTitle => _channelTitle;

  String get contentType => _contentType;

  String get defaultThumbnail => _defaultThumbnail;

  String get highThumbnail => _highThumbnail;

  DateTime get publishedAt => _publishedAt;
}
