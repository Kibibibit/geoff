import 'dart:convert';

import 'package:geoff/utils/networking/status_code.dart';
import 'package:geoff/utils/system/log.dart';
import 'package:http/http.dart' as http;

/// Basic Rest Client
/// Authors - Dan M
class MayRest {

  static final Log _logger = Log("MayRest");


  /// The token of the currently logged in user
  static String? userToken;


  static const Map<String,String> defaultHeaders = {'Content-Type': 'application/json','Accept': 'application/json'};

  /// Adds headers, plus [userToken] onto an api call
  static Map<String, String> _addAuth(Map<String, String> headers, [bool noToken = false]) {

    Map<String, String> newHeaders = {};

    newHeaders.addAll(headers);

    if (userToken != null && !noToken) {
      newHeaders["Authorization"] = "Bearer $userToken";
    } else if (!noToken && userToken == null) {
      _logger.warning("noToken is true but no token is set! make sure to set userToken!");
    }

    return newHeaders;

  }

  static String _responseOutput(http.Response r) => "Request: ${r.request} returned Status Code: ${r.statusCode} (${StatusCode.codeValue(r.statusCode)}).\nHeaders: ${r.headers}\nBody: ${r.body}";


  static Future<http.Response> get(
    String url, 
    {
      bool quiet = false, 
      bool noToken = false, 
      Map<String, String> headers = defaultHeaders
    }
  ) {

    if (!quiet) _logger.info("GETting data from $url using ${userToken == null || noToken ? "no token" : "token: $userToken"}");
    return http.get(Uri.parse(Uri.encodeFull(url)), headers: _addAuth(headers,noToken)).then((response) {
      _logger.info(_responseOutput(response));
      return response;
    });

  }

  static Future<http.Response> post(
    String url,
    dynamic body,
    {
      bool quiet = false, 
      bool noToken = false, 
      Map<String, String> headers = defaultHeaders
    }
  ) {
    
    
    if (headers["Content-Type"] == "application/json" && body != null) {
      body = jsonEncode(body);
    }

    if (!quiet) _logger.info("POSTting ${body == null ? "empty data" : "$body"} from $url using ${userToken == null || noToken ? "no token" : "token: $userToken"}");

    return http.post(Uri.parse(Uri.encodeFull(url)), body: body, headers:_addAuth(headers, noToken)).then((response) {
      _logger.info(_responseOutput(response));
      return response;
    });

  }


}