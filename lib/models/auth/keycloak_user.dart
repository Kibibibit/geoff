import 'package:geoff/models/model_utils.dart';

import 'geoff_user.dart';

class KeycloakUser extends GeoffUser {

  late int _createdTimestamp;
  late List<String> _requiredActions;
  late bool _enabled;

  String? _email;
  String? _firstName;
  String? _lastName;
  bool? _emailVerified;

  Map<String,List<String>>? _attributes;

  List<String> get requiredActions => _requiredActions;
  int get createdTimestamp => _createdTimestamp;
  bool get enabled => _enabled;

  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  bool? get emailVerified => _emailVerified;
  Map<String, List<String>>? get attributes => _attributes;



  void setCreatedTimestamp(int createdTimestamp) {
    _createdTimestamp = createdTimestamp;
  }

  void setEmail(String? email) {
    _email = email;
  }

  void setFirstName(String? firstName) {
    _firstName = firstName;
  }

  void setLastName(String? lastName) {
    _lastName = lastName;
  }

  void setEmailVerified(bool? emailVerified) {
    _emailVerified = emailVerified;
  }

  void setAttributes(Map<String, List<String>>? attributes) {
    _attributes = attributes;
  }

  void setRequiredActions(List<String> requiredActions) {
    _requiredActions = requiredActions;
  }

  void setEnabled(bool enabled) {
    _enabled = enabled;
  }


  static KeycloakUser fromKeycloakRep(Map<String, dynamic> map) {

    KeycloakUser user = GeoffUser.fromMap(map) as KeycloakUser;
    user..setCreatedTimestamp(ModelUtils.getField<int>(map, "createdTimestamp"))
    ..setEmail(ModelUtils.getField<String?>(map, "email"))
    ..setFirstName(ModelUtils.getField<String?>(map, "firstName"))
    ..setLastName(ModelUtils.getField<String?>(map, "lastName"))
    ..setEmailVerified(ModelUtils.getField<bool?>(map, "emailVerified"))
    ..setAttributes(ModelUtils.getField<Map<String, List<String>>?>(map, "attributes"))
    ..setRequiredActions(ModelUtils.getField<List<String>>(map, "requiredActions"))
    ..setEnabled(ModelUtils.getField<bool>(map, "enabled"));

    return user;
  }


}