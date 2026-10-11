enum UsagePurpose { school, work, personal }

class UserModel {
  final String _id;
  final String? _userName;
  final String? _email;
  final List<String>? _usagePurpose;

  const UserModel({
    required this._id,
    this._userName,
    this._email,
    this._usagePurpose,
  });

  String get id => _id;
  String? get userName => _userName;
  String? get email => _email;
  List<String>? get usagePurpose => _usagePurpose;
}
