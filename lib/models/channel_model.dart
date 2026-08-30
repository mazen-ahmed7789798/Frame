import 'package:frame/models/content_model.dart';

class Channel implements Content {
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

  Channel(
    this._contentId,
    this._contentType,
    this._defaultThumbnail,
    this._mediumThumbnail,
    this._highThumbnail,
    this._contentTitle,
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
    };
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      json["id"],
      json["kind"],
      json["title"],
      json["defaultThumbnail"],
      json["mediumThumbnail"],
      json["highThumbnail"],
      DateTime.parse(json["publishedAt"]),
    );
  }

  String get channelId => _contentId;

  String get contentType => _contentType;

  String get defaultThumbnail => _defaultThumbnail;

  String get highThumbnail => _highThumbnail;

  String get mediumThumbnail => _mediumThumbnail;

  String get channelTitle => _contentTitle;

  DateTime get publishedAt => _publishedAt;
}
