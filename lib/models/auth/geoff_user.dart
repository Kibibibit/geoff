import 'package:geoff/models/model_utils.dart';

class GeoffUser {

  late String _id;
  late String _username;

  String get id => _id;
  String get username => _username;


  void setId(String id) {
    _id = id;
  }

  void setUsername(String username) {
    _username = username;
  }




  static GeoffUser fromMap(Map<String, dynamic> map) {

    GeoffUser user = GeoffUser();
    user..setId(ModelUtils.getField<String>(map, "id"))
    ..setUsername(ModelUtils.getField<String>(map, "username"));

    return user;
  }


}