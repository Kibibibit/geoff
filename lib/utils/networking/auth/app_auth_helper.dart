import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:geoff/geoff.dart';

/// This class can be used to log in using a [FlutterAppAuth]. It contains several helper methods
/// and stores a lot of parameters statically to help set up the project.
/// Keep in mind this is designed specifically with keycloak in mind and
/// has not been tested with other auth providers
abstract class AppAuthHelper {
  static final Log _logger = Log("AppAuthHelper");

  AppAuthHelper._();

  /// Disable the colors in the logs if your terminal does not support escape codes
  static void disableColors() {
    _logger.setColors(false);
  }

  static final FlutterAppAuth _appAuth = FlutterAppAuth();

  static String? _redirectUrl;
  static String? _clientId;
  static String? _realm;
  static String? _authServerUrl;
  static List<String>? _scopes;

  /// Sets the redirecturl that will be called once login is complete. Should match
  /// the redirect url you set in build.gradle
  static void setRedirectUrl(String redirectUrl) {
    _redirectUrl = redirectUrl;
  }

  /// Sets the client id of your application within keycloak
  static void setClientId(String clientId) {
    _clientId = clientId;
  }

  /// Sets the keycloak realm of your project
  static void setRealm(String realm) {
    _realm = realm;
  }

  /// Sets the base auth server url, eg: https://keycloak.example.com/auth
  static void setAuthServerUrl(String authServerUrl) {
    _authServerUrl = authServerUrl;
  }

  ///Sets the scopes
  static void setScopes(List<String> scopes) {
    _scopes = scopes;
  }

  static String get discoveryUrl {
    return "$_authServerUrl/realms/$_realm/.well-known/openid-configuration";
  }

  static bool _checkFields(String? redirectUrl, String? clientId, String? realm,
      String? authServerUrl) {
    redirectUrl ??= _redirectUrl;
    if (redirectUrl == null) {
      _logger.error(
          "Redirect URL is null! You can set it with setRedirectUrl, or pass it into this method");
      return false;
    }

    setRedirectUrl(redirectUrl);

    clientId ??= _clientId;
    if (clientId == null) {
      _logger.error(
          "Client ID is null! You can set it with setClientId, or pass it into this method");
      return false;
    }
    setClientId(clientId);

    realm ??= _realm;
    if (realm == null) {
      return false;
    }
    setRealm(realm);

    authServerUrl ??= _authServerUrl;
    if (authServerUrl == null) {
      _logger.error(
          "Auth Server URL is null! You can set it with setAuthServerUrl, or pass it into this method");
      return false;
    }
    setAuthServerUrl(authServerUrl);

    return true;
  }

  /// Will open up a browser showing the authentication provider and attempt to get a token. Returns true on a successful token.
  /// Calls [Session.onToken] on success so you can get your token from [Session.token].
  /// Setting [tokenLoop] to true will automatically make it call [Session.startTokenLoop] on successful login
  static Future<bool> login(
      {bool tokenLoop = true,
      String? redirectUrl,
      String? clientId,
      String? realm,
      String? authServerUrl}) async {
    _logger.debug("Trying to log in!");
    if (!_checkFields(redirectUrl, clientId, realm, authServerUrl)) {
      return false;
    }

    _logger.debug("Discovery URL is: $discoveryUrl");

    AuthorizationTokenResponse? result =
        await _appAuth.authorizeAndExchangeCode(AuthorizationTokenRequest(
            _clientId!, _redirectUrl!,
            discoveryUrl: discoveryUrl, scopes: _scopes));

    if (result == null) {
      _logger.warning("Auth Token Request returned null!");
      return false;
    }

    bool success = Session.onToken(result);

    if (success) {
      Session.startTokenLoop();
    }
    return success;
  }

  /// Logs the user out, based on the given tokenId. Will automatically grab the one from [Session] by default
  /// Returns true on successful logout
  static Future<bool> logout(
      {String? tokenId,
      String? redirectUrl,
      String? clientId,
      String? realm,
      String? authServerUrl}) async {
    if (!_checkFields(redirectUrl, clientId, realm, authServerUrl)) {
      return false;
    }

    tokenId ??= Session.tokenResponse?.idToken;

    if (tokenId == null) {
      _logger.error("Don't have a token id!");
      Session.onLogout();
      return false;
    }

    _logger.debug("Discovery URL is: $discoveryUrl");

    EndSessionResponse? endSessionResponse =
        await _appAuth.endSession(EndSessionRequest(
      idTokenHint: tokenId,
      postLogoutRedirectUrl: _redirectUrl,
      discoveryUrl: discoveryUrl,
    ));

    if (endSessionResponse != null) {
      _logger.debug("End Session State: ${endSessionResponse.state}");
      Session.onLogout();
      return true;
    }
    _logger.error("End Session response was null!");
    Session.onLogout();
    return false;
  }

  /// Refreshes the token using the given refresh token. By default, does not update the session.
  /// DON'T CALL THIS: Unless you are manually handling session data
  static Future<TokenResponse?> refreshToken(String refreshToken,
      {String? redirectUrl,
      String? clientId,
      String? realm,
      String? authServerUrl}) async {
    if (!_checkFields(redirectUrl, clientId, realm, authServerUrl)) {
      return null;
    }

    _logger.debug("Trying to refresh token!");
    TokenResponse? result = await _appAuth.token(TokenRequest(
        _clientId!, _redirectUrl!,
        discoveryUrl: discoveryUrl,
        refreshToken: refreshToken,
        scopes: _scopes));

    if (result == null) {
      _logger.warning("Getting refresh token returned null!");
    }
    return result;
  }
}
