/// Http 异常处理
/// 异常大体分为以下几种：
/// 1、网络异常
/// 2、客户端请求异常（a、请求参数/路径错误，b、鉴权失败/token失效）
/// 3、服务端异常
class HttpException implements Exception {
  final String? _message;

  String get message => _message ?? runtimeType.toString();

  final int? _code;

  int get code => _code ?? -1;

  HttpException([this._message, this._code]);

  @override
  String toString() {
    return "code:$code, message=$message";
  }
}

/// 客户端请求错误
class BadRequestException extends HttpException {
  BadRequestException({String? message, int? code}) : super(message, code);
}

/// 服务端响应错误
class BadServiceException extends HttpException {
  BadServiceException({String? message, int? code}) : super(message, code);
}

class UnknownException extends HttpException {
  UnknownException([String? message]) : super(message);
}

class CancelException extends HttpException {
  CancelException([String? message]) : super(message);
}

class NetworkException extends HttpException {
  NetworkException({String? message, int? code}) : super(message, code);
}

/// 401
class UnauthorisedException extends HttpException {
  UnauthorisedException({String? message, int? code = 401}) : super(message);
}

class BadResponseException extends HttpException {
  dynamic data;

  BadResponseException([this.data]) : super();
}
