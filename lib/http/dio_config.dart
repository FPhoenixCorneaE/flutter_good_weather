import 'package:dio/dio.dart';

/// Dio 配置项
/// [baseUrl] 域名
/// [proxy] 代理地址
/// [cookiesPath] cookie本地缓存地址
/// [interceptors] 自定义拦截器
/// [connectTimeout] 连接超时时间
/// [sendTimeout] 发送超时时间
/// [receiveTimeout] 接收超时时间
class DioConfig {
  final String? baseUrl;
  final String? proxy;
  final String? cookiesPath;
  final List<Interceptor>? interceptors;
  final Map<String, dynamic>? headers;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;

  DioConfig({
    this.baseUrl,
    this.proxy,
    this.cookiesPath,
    this.interceptors,
    this.headers,
    this.connectTimeout = Duration.millisecondsPerMinute,
    this.sendTimeout = Duration.millisecondsPerMinute,
    this.receiveTimeout = Duration.millisecondsPerMinute,
  });
}
