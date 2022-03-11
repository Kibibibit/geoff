import 'dart:convert';

import 'package:geoff/utils/system/log.dart';
import 'package:http/http.dart' as http;


class MayRest {

  static final Log _logger = Log("MayRest");


  /// The token of the currently logged in user
  static String? userToken;

  /// Adds headers, plus [userToken] onto an api call
  static Map<String, String> _addAuth(Map<String, String> headers, [bool noToken = false]) {

    Map<String, String> newHeaders = {};

    newHeaders.addAll(headers);

    if (userToken != null && !noToken) {
      newHeaders["Authorization"] = "Bearer $userToken";
    }

    return newHeaders;

  }

  static String _responseOutput(http.Response r) => "Request: ${r.request} returned Status Code: ${r.statusCode}.\nHeaders: ${r.headers}\nBody: ${r.body}";


  static Future<http.Response> get(
    String url, 
    {
      bool quiet = false, 
      bool noToken = false, 
      Map<String, String> headers =  const {'Content-Type': 'application/json','Accept': 'application/json'}
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
      Map<String, String> headers = const {'Content-Type': 'application/json','Accept': 'application/json'}
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