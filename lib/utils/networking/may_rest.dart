import 'dart:convert';

import 'package:geoff/utils/networking/auth/session.dart';
import 'package:geoff/utils/networking/status_code.dart';
import 'package:geoff/utils/system/log.dart';
import 'package:http/http.dart' as http;

/// Basic Rest Client
/// Authors - Dan M
abstract class MayRest {
  static final Log _logger = Log("MayRest");


  MayRest._();

  /// Allows you to disable colors for this logger
  static void disableColors() {
    _logger.setColors(false);
  }

  static Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  /// Gets the default headers applied to every request
  static Map<String, String> get defaultHeaders => _defaultHeaders;

  /// Allows you to override the default headers applied to every request
  static void setDefaultHeaders(Map<String, String> headers) {
    _defaultHeaders = headers;
  }

  /// Adds headers, plus [Session.token] onto an api call
  static Map<String, String> _addAuth(Map<String, String> headers,
      [bool noToken = false, String? token]) {
    Map<String, String> newHeaders = {};

    newHeaders.addAll(headers);
    
    if (token != null && !noToken) {
      newHeaders["Authorization"] = "Bearer $token";
    } else if (!noToken && token == null) {
      _logger.warning(
          "noToken is true but no token is set! make sure to set Session.token, or pass a token into your request");
    }

    return newHeaders;
  }

  /// Just a helper function to make the logs nicer
  static String _tokenString(String? token, bool noToken) {
    return token == null || noToken
        ? "no token"
        : "token: ${token.substring(0, (token.length * 0.1).round())}...";
  }

  /// Log the output at a specific level based on output
  static void _responseOutput(http.Response r) {
    Level level = Level.info;
    if (r.statusCode >= 300) {
      level = Level.warning;
    }
    if (r.statusCode >= 400) {
      level = Level.error;
    }
    if (r.statusCode == StatusCode.imATeapot) {
      level = Level.wtf;
    }

    _logger.logAt(level,
        "Request: ${r.request} returned Status Code: ${r.statusCode} (${StatusCode.codeValue(r.statusCode)}).\nHeaders: ${r.headers}\nBody: ${r.body}");
  }

  /// Makes a request at the requested [_RequestType] level
  static Future<http.Response> _makeRequest(_RequestType requestType, String url, {Object? body, bool quiet = false, String? token, bool noToken = false, Map<String,String>? headers}) {

      Map<String, String> _headers = defaultHeaders;
      _headers.addAll(headers ?? {});

      token ??= Session.token;

      _headers = _addAuth(_headers, noToken, token);

      if (_headers.containsValue("application/json") && body != null) {
        body = jsonEncode(body);
      }

      Uri uri = Uri.parse(Uri.encodeFull(url));

      Map<_RequestType, Future<http.Response>> functions = {
        _RequestType.get : http.get(uri, headers: _headers),
        _RequestType.post : http.post(uri, body: body, headers: _headers),
        _RequestType.put : http.put(uri, body: body, headers: _headers),
        _RequestType.delete : http.delete(uri, body: body, headers: _headers),
        _RequestType.patch : http.patch(uri, body: body, headers: headers)
      };

      if (!quiet) _logger.info("Sending ${requestType.name.toUpperCase()} request to ${url.toString()} using token: ${_tokenString(token, noToken)} ${body == null ? "" : ", with body: ${body.toString()}"}");
      
      return functions[requestType]!.then((http.Response response) {
        if (!quiet) _responseOutput(response);
        return response;
      });
  }

  /// Makes a GET request to url
  static Future<http.Response> get(String url, {bool quiet = false, String? token, bool noToken = false, Map<String,String>? headers}) => 
    _makeRequest(_RequestType.get, url, quiet: quiet, noToken: noToken, headers: headers, token: token);

  /// Makes a POST request to url
  static Future<http.Response> post(String url, {Object? body, bool quiet = false, String? token, bool noToken = false, Map<String,String>? headers}) =>
    _makeRequest(_RequestType.post, url, body: body, quiet: quiet, noToken: noToken, headers: headers, token: token);

  /// Makes a PUT request to url
  static Future<http.Response> put(String url, {Object? body, bool quiet = false, String? token, bool noToken = false, Map<String, String>? headers}) =>
    _makeRequest(_RequestType.put, url, body: body, quiet: quiet, noToken: noToken, headers: headers, token: token);

  /// Makes a DELETE request to url
  static Future<http.Response> delete(String url, {Object? body, bool quiet = false, String? token, bool noToken = false, Map<String, String>? headers}) =>
    _makeRequest(_RequestType.delete, url, body: body, quiet: quiet, noToken: noToken, headers: headers, token: token);

  /// Makes a PATCH request to url
  static Future<http.Response> patch(String url, {Object? body, bool quiet = false, String? token, bool noToken = false, Map<String, String>? headers}) =>
    _makeRequest(_RequestType.patch, url, body: body, headers: headers, quiet:  quiet, noToken: noToken, token: token);


}

enum _RequestType {
  get,
  post,
  put,
  delete,
  patch
}
