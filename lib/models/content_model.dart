abstract class Content {
  late String _contentTitle;
  late String _contentId;
  late String _contentType;
  late DateTime _publishedAt;
  late String _defaultThumbnail;
  late String _mediumThumbnail;
  late String _highThumbnail;

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  factory Content.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
