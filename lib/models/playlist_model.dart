import "package:frame/models/content_model.dart";

class Playlist implements Content {
  late final String _channelTitle;

  late final int _highThumbnailWidth;
  late final int _highThumbnailHeight;

  late final int _mediumThumbnailWidth;
  late final int _mediumThumbnailHeight;

  late final int _defaultThumbnailHeight;
  late final int _defaultThumbnailwidth;

  late final String _description;

  @override
  late final String _contentId;

  @override
  late final String _contentType;

  @override
  late final String _defaultThumbnail;

  @override
  late final String _highThumbnail;

  @override
  late final String _mediumThumbnail;

  @override
  late final DateTime _publishedAt;

  @override
  late final String _contentTitle;

  Playlist(
    this._channelTitle,
    this._contentId,
    this._contentType,
    this._defaultThumbnail,
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

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      json["channelTitle"],
      json["id"],
      json["kind"],
      json["defaultThumbnail"],
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
