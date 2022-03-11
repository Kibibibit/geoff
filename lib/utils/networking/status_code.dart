

/// Stores mappings of all common Http Status codes
/// Author(s) - Dan M
class StatusCode {


  // 100 Codes
  /// Couldn't use continue because its a keywork :(
  static const int cont = 100;
  static const int switchingProtocols = 101;
  static const int processing = 102;
  static const int earlyHints = 103;

  // 200 Codes
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int nonAuthoritativeInformation = 203;
  static const int noContent = 204;
  static const int resetContent = 205;
  static const int partialContent = 206;
  static const int multiStatus = 207;
  static const int alreadyReported = 208;
  static const int imUsed = 226;

  // 300 Codes
  static const int multipleChoices = 300;
  static const int movedPermanently = 301;
  static const int found = 302;
  static const int seeOther = 303;
  static const int notModified = 304;
  static const int useProxy = 305;
  static const int switchProxy = 306;
  static const int temporaryRedirect = 307;
  static const int permanentRedirect = 308;

  // 400 Codes
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int paymentRequired = 402;
  static const int forbidden = 403;
  static const int notFond = 404;
  static const int methodNotAllowed = 405;
  static const int notAcceptable = 406;
  static const int proxyAuthenticationRequired = 407;
  static const int requestTimeout = 408;
  static const int conflict = 409;
  static const int gone = 410;
  static const int lengthRequired = 411;
  static const int preconditionFailed = 412;
  static const int payloadTooLarge = 413;
  static const int uriTooLong = 414;
  static const int unsupportedMediaType = 415;
  static const int rangeNotSatisfiable = 416;
  static const int expectationFailed = 417;
  static const int imATeapot = 418;
  static const int misdirectedRequest = 421;
  static const int unprocessableEntity = 422;
  static const int locked = 423;
  static const int failedDependency = 424;
  static const int tooEarly = 425;
  static const int upgradeRequired = 426;
  static const int preconditionRequired = 428;
  static const int tooManyRequests = 429;
  static const int requestHeaderFieldsTooLarge = 431;
  static const int unavailableForLegalReasons = 451;

  // 500 status codes
  static const int internalServerError = 500;
  static const int notImplemented = 501;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
  static const int httpVersionNotSupported = 505;
  static const int variantAlsoNegotiates = 506;
  static const int insufficientStorage = 507;
  static const int loopDetected = 508;
  static const int notExtended = 510;
  static const int networkAuthenticationRequired = 511;


  static String codeValue(int code) {
    if (_asString.containsKey(code)) {
      return _asString[code]!;
    } else {
      return "Status Code $code Unknown";
    }
  }


  static const Map<int, String> _asString = {
    // 100 Codes
    cont:"Continue",
    switchingProtocols:"Switching Protocols",
    processing:"Processing",
    earlyHints:"Early Hints",
    // 200 Codes
    ok:"OK",
    created:"Created",
    accepted:"Accepted",
    nonAuthoritativeInformation:"Non-Authoritative Information",
    noContent:"No Content",
    resetContent:"Reset Content",
    partialContent:"Partial Content",
    multiStatus:"Multi-Status",
    alreadyReported:"Already Reported",
    imUsed:"IM Used",
    // 300 Codes
    multipleChoices:"Multiple Choices",
    movedPermanently:"Moved Permanently",
    found:"Found",
    seeOther:"See Other",
    notModified:"Not Modified",
    useProxy:"Use Proxy",
    switchProxy:"Switch Proxy",
    temporaryRedirect:"Temporary Redirect",
    permanentRedirect:"Permanent Redirect",
    // 400
    badRequest:"Bad Request",
    unauthorized:"Unauthorized",
    paymentRequired:"Payment Required",
    forbidden:"Forbidden",
    notFond:"Not Found",
    methodNotAllowed:"Method Not Allowed",
    notAcceptable:"Not Acceptable",
    proxyAuthenticationRequired:"Proxy Authentication Required",
    requestTimeout:"Request Timeout",
    conflict:"Conflict",
    gone:"Gone",
    lengthRequired:"Length Required",
    preconditionFailed:"Precondition Failed",
    payloadTooLarge:"Payload Too Large",
    uriTooLong:"URI Too Long",
    unsupportedMediaType:"Unsupported Media Type",
    rangeNotSatisfiable:"Range Not Satisfiable",
    expectationFailed:"Expectation Failed",
    imATeapot:"I'm a teapot",
    misdirectedRequest:"Misdrected Request",
    unprocessableEntity:"Unprocessable Entity",
    locked:"Locked",
    failedDependency:"Failed Dependency",
    tooEarly:"Too Early",
    upgradeRequired:"Upgrade Required",
    preconditionRequired:"Precondition Required",
    tooManyRequests:"Too Many Requests",
    requestHeaderFieldsTooLarge:"Request Header Fields Too Large",
    unavailableForLegalReasons:"Unavailable For Legal Reasons",
    //500 Codes
    internalServerError:"Internal Server Error",
    notImplemented:"Not Implemented",
    badGateway:"Bad Gateway",
    serviceUnavailable:"Service Unavailable",
    gatewayTimeout:"Gateway Timeout",
    httpVersionNotSupported:"HTTP Version Not Supported",
    variantAlsoNegotiates:"Variant Also Negotiates",
    insufficientStorage:"Insufficient Storage",
    loopDetected:"Loop Detected",
    notExtended:"Not Extended",
    networkAuthenticationRequired:"Network Authentication Required"

  };

}