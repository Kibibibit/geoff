import 'package:geoff/models/model_utils.dart';

import 'geoff_user.dart';

/// Represents a keycloak user, based on the model returned by a `UserRepresentation` from
/// the java keycloak api
class KeycloakUser extends GeoffUser {

  late int _createdTimestamp;
  late List<String> _requiredActions;
  late bool _enabled;

  String? _email;
  String? _firstName;
  String? _lastName;
  bool? _emailVerified;

  Map<String,List<String>>? _attributes;

  /// A list of required actions by the user
  List<String> get requiredActions => _requiredActions;
  /// The timestamp that the user is created
  int get createdTimestamp => _createdTimestamp;
  /// If the user is actually enabled
  bool get enabled => _enabled;

  /// The email of the user
  String? get email => _email;
  /// The first name of the user
  String? get firstName => _firstName;
  /// The last name of the user
  String? get lastName => _lastName;
  /// If the user's email is verified
  bool? get emailVerified => _emailVerified;
  /// A map of attributes
  Map<String, List<String>>? get attributes => _attributes;


  /// Sets the created timestamp of the user
  void setCreatedTimestamp(int createdTimestamp) {
    _createdTimestamp = createdTimestamp;
  }

  /// Sets the email of the user
  void setEmail(String? email) {
    _email = email;
  }

  /// Sets the first name of the user
  void setFirstName(String? firstName) {
    _firstName = firstName;
  }

  /// Sets the last name of the user
  void setLastName(String? lastName) {
    _lastName = lastName;
  }

  /// Sets if the email is verified
  void setEmailVerified(bool? emailVerified) {
    _emailVerified = emailVerified;
  }

  /// Sets the attributes
  void setAttributes(Map<String, List<String>>? attributes) {
    _attributes = attributes;
  }

  /// Sets the required actions
  void setRequiredActions(List<String> requiredActions) {
    _requiredActions = requiredActions;
  }

  /// Sets if the user is enabled
  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  /// Converts a map into a `KeycloakUser`. This map is based on the json returned by the keycloak java api.
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