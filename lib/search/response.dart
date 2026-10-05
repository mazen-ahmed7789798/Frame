class Response {
  final String? _message;
  final dynamic _data;
  final bool? _success;

  Response({this._message, this._data, this._success});

  String? get message => _message;
  dynamic get data => _data;
  bool? get success => _success;
}
