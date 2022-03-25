
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:geoff/utils/system/log.dart';

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

  /// Will open up a browser showing the authentication provider and attempt to get a token. Returns null if closed or if there is an error
  /// with the config
  static Future<AuthorizationTokenResponse?> login({String? redirectUrl, String? clientId, String? realm, String? authServerUrl}) async {

    redirectUrl ??= _redirectUrl;
    if (redirectUrl == null) {
      _logger.error("Redirect URL is null! You can set it with setRedirectUrl, or pass it into this method");
      return null;
    }

    clientId ??= _clientId;
    if (clientId == null) {
      _logger.error("Client ID is null! You can set it with setClientId, or pass it into this method");
      return null;
    }

    realm ??= _realm;
    if (realm == null) {
      _logger.error("Realm is null! You can set it with setRealm, or pass it into this method");
      return null;
    }

    authServerUrl ??= _authServerUrl;
    if (authServerUrl == null) {
      _logger.error("Auth Server URL is null! You can set it with setAuthServerUrl, or pass it into this method");
      return null;
    }


    String discoveryurl = "$authServerUrl/realms/$realm/.well-known/openid-configuration";

    _logger.debug("Discovery URL is: $discoveryurl");

    AuthorizationTokenResponse? result = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId, 
        redirectUrl,
        discoveryUrl: discoveryurl,
        scopes: _scopes
      )
    );

    if (result == null) {
      _logger.warning("Auth Token Request returned null!");
    }

    return result;

  }

}