import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:geoff/geoff.dart';
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
  static TokenResponse? tokenResponse;

  /// The string representation of your token, equivilant to [tokenResponse.accessToken!]
  static String? token;

  /// The refresh token from the token response, equivilant to [tokenResponse.refreshToken!]
  static String? refreshToken;

  /// A map storing the information from your token, decoded using jaguar jwt
  static Map<String, dynamic> tokenData = {};

  /// Stores the [DateTime] that this token is refreshed at
  static DateTime? refreshesAt;

  /// The amount of time before a token expires that it will be refreshed
  static Duration refreshBefore = const Duration(seconds: 10);

  static bool _doRefreshToken = false;

  static Alarm? _refreshAlarm;

  /// Whether or not the refreshToken loop is running
  static bool get doRefreshToken => _doRefreshToken;

  /// Call this when you get your token. Will return false if the token was null, true otherwise
  static bool onToken(TokenResponse response) {
    if (response.accessToken != null) {
      _logger.info("Got a token!");
      tokenResponse = response;
      token = response.accessToken!;
      refreshToken = response.refreshToken!;

      if (response.accessTokenExpirationDateTime != null) {
        refreshesAt = response.accessTokenExpirationDateTime;
      }

      List<String> parts = token!.split('.');
      String payload = parts[1];
      String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      tokenData = json.decode(decoded);
      return true;
    } else {
      _logger.error("Token was null!");
      return false;
    }
  }

  /// Starts the refresh token loop, will refresh [refreshBefore] before
  /// the token expires. You can stop with [stopRefreshTokenLoop]
  static void startTokenLoop() {
    _doRefreshToken = true;
    _refreshTokenLoop();
  }

  static void _refreshTokenLoop() {
    if (_doRefreshToken && refreshesAt != null && refreshToken != null) {
      _refreshAlarm = Alarm.at(refreshesAt!.subtract(refreshBefore), () async {
        TokenResponse? result = await AppAuthHelper.refreshToken(refreshToken!);
        if (result != null) {
          if (onToken(result)) {
            _refreshTokenLoop();
            return;
          }
          return;
        }
        _logger.error("Got null token response!");
        _doRefreshToken = false;
      });
    }
  }


  /// Stops the token refresh loop
  static void stopRefreshTokenLoop() {
    if (_doRefreshToken && _refreshAlarm != null) {
      if (_refreshAlarm!.isActive) {
        _refreshAlarm!.cancel();
      }
      _doRefreshToken = false;
      _logger.info("Stopped refresh token loop!");
      return;
    }
    _logger.warning("No refresh token loop running to stop!");
  }

  static void onLogout() {
    stopRefreshTokenLoop();
    tokenResponse = null;
    token = null;
    refreshToken = null;
    tokenData = {};
  }
}
