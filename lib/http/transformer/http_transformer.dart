import 'package:dio/dio.dart';

import '../http_response.dart';

/// Response 解析
/// 遵守 SOLID 原则定义一个抽象解析策略
abstract class HttpTransformer {
  HttpResponse parse(Response response);
}
