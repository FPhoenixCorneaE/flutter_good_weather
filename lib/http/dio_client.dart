import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_good_weather/util/log_util.dart';

import 'dio_config.dart';

/// Dio 客户端
class DioClient with DioMixin implements Dio {
  DioClient({BaseOptions? options, DioConfig? dioConfig}) {
    options ??= BaseOptions(
      baseUrl: dioConfig?.baseUrl ?? "",
      contentType: "application/json",
      headers: dioConfig?.headers,
      connectTimeout: Duration(milliseconds: dioConfig?.connectTimeout ?? Duration.millisecondsPerMinute),
      sendTimeout: Duration(milliseconds: dioConfig?.sendTimeout ?? Duration.millisecondsPerMinute),
      receiveTimeout: Duration(milliseconds: dioConfig?.receiveTimeout ?? Duration.millisecondsPerMinute),
    );
    this.options = options;

    // 添加缓存拦截器
    final cacheOptions = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(days: 7),
    );
    interceptors.add(DioCacheInterceptor(options: cacheOptions));
    // 添加日志拦截器
    interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (object) {
        LogUtil.d(object);
      },
    ));
    // 添加Cookie管理拦截器
    if (dioConfig?.cookiesPath?.isNotEmpty ?? false) {
      interceptors.add(CookieManager(PersistCookieJar(storage: FileStorage(dioConfig!.cookiesPath))));
    }
    // 添加配置项中的拦截器
    if (dioConfig?.interceptors?.isNotEmpty ?? false) {
      interceptors.addAll(dioConfig!.interceptors!);
    }

    httpClientAdapter = IOHttpClientAdapter();
  }

  /// 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
  setProxy(String proxy) {
    httpClientAdapter = IOHttpClientAdapter()..onHttpClientCreate = (client) {
      // config the http client
      client.findProxy = (uri) {
        // proxy all request to localhost:8888
        return "PROXY $proxy";
      };
      // 代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
      client.badCertificateCallback = (cert, host, port) => true;
      return null;
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
  }
}
