
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:geoff/utils/system/log.dart';

class AppAuthHelper {

  static final Log _logger = Log("AppAuthHelper");

  static void disableColors() {
    _logger.setColors(false);
  }

  static final FlutterAppAuth _appAuth = FlutterAppAuth();

  static String? _redirectUrl;
  static String? _clientId;
  static String? _realm;
  static String? _authServerUrl;

  static void setRedirectUrl(String redirectUrl) {
    _redirectUrl = redirectUrl;
  }

  static void setClientId(String clientId) {
    _clientId = clientId;
  }

  static void setRealm(String realm) {
    _realm = realm;
  }

  static void setAuthServerUrl(String authServerUrl) {
    _authServerUrl = authServerUrl;
  }

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
        discoveryUrl: discoveryurl
      )
    );

    if (result == null) {
      _logger.warning("Auth Token Request returned null!");
    }

    return result;

  }

}