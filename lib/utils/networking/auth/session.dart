
import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:geoff/utils/system/log.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

/// Stores session data for the project, related to authentication and such.
class Session {

  static final Log _logger = Log("Session");

  /// Disable the colors in the logs if your terminal does not support escape codes
  static void disableColors() {
    _logger.setColors(false);
  }

  /// The response to an attempt to get an authentication token.
  /// Make sure to set before use
  static late AuthorizationTokenResponse tokenResponse;

  /// The string representation of your token, equivilant to [tokenResponse.accessToken!]
  static late String token;

  /// The refresh token from the token response, equivilant to [tokenResponse.refreshToken!]
  static late String refreshToken;

  /// A map storing the information from your token, decoded using jaguar jwt
  static Map<String, dynamic>  tokenData = {};

  /// Call this when you get your token. Will return false if the token was null, true otherwise
  static bool onToken(AuthorizationTokenResponse response) {

    if (response.accessToken != null) {
      _logger.info("Got a token!");
      tokenResponse = response;
      token = response.accessToken!;
      refreshToken = response.refreshToken!;

      List<String> parts = token.split('.');
      String payload = parts[1];
      String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      tokenData = json.decode(decoded);
      return true;
    } else {
      _logger.error("Token was null!");
      return false;
    }


    
  }

}