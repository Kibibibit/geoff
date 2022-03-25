import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:geoff/geoff.dart';

/// This class can be used to log in using a [FlutterAppAuth]. It contains several helper methods
/// and stores a lot of parameters statically to help set up the project.
/// Keep in mind this is designed specifically with keycloak in mind and
/// has not been tested with other auth providers
class AppAuthHelper {
  static final Log _logger = Log("AppAuthHelper");

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

  /// Will open up a browser showing the authentication provider and attempt to get a token. Returns null if closed or if there is an error
  /// with the config
  static Future<AuthorizationTokenResponse?> login(
      {String? redirectUrl,
      String? clientId,
      String? realm,
      String? authServerUrl}) async {
    _logger.debug("Trying to log in!");
    if (!_checkFields(redirectUrl, clientId, realm, authServerUrl)) {
      return null;
    }

    _logger.debug("Discovery URL is: $discoveryUrl");

    AuthorizationTokenResponse? result =
        await _appAuth.authorizeAndExchangeCode(AuthorizationTokenRequest(
            _clientId!, _redirectUrl!,
            discoveryUrl: discoveryUrl, scopes: _scopes));

    if (result == null) {
      _logger.warning("Auth Token Request returned null!");
    }

    return result;
  }

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
      return false;
    }

    _logger.debug("Discovery URL is: $discoveryUrl, tokenId is $tokenId. Redirect url is $redirectUrl");

    EndSessionResponse? endSessionResponse =
        await _appAuth.endSession(EndSessionRequest(
      idTokenHint: tokenId,
      postLogoutRedirectUrl: redirectUrl,
      discoveryUrl: discoveryUrl,
    ));

    if (endSessionResponse != null) {
      _logger.debug("End Session State: ${endSessionResponse.state}");
      return true;
    }
    _logger.error("End Session response was null!");
    return false;
  }

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
