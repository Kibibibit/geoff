import 'package:geoff/models/model_utils.dart';

/// A basic user object, containing an id and username
class GeoffUser {

  late String _id;
  late String _username;

  /// The id of the user
  String get id => _id;
  /// The username of the user
  String get username => _username;

  ///Sets the id of the user
  void setId(String id) {
    _id = id;
  }

  ///Sets the username of the user
  void setUsername(String username) {
    _username = username;
  }

  ///Creates the user from a map
  static GeoffUser fromMap(Map<String, dynamic> map) {

    GeoffUser user = GeoffUser();
    user..setId(ModelUtils.getField<String>(map, "id"))
    ..setUsername(ModelUtils.getField<String>(map, "username"));

    return user;
  }


}