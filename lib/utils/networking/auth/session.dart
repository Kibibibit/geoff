
import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:geoff/utils/system/log.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class Session {

  static final Log _logger = Log("Session");

  static void disableColors() {
    _logger.setColors(false);
  }

  static late AuthorizationTokenResponse tokenResponse;
  static late String token;
  static late String refreshToken;
  static Map<String, dynamic>  tokenData = {};


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