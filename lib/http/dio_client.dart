import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'dio_config.dart';

/// Dio 客户端
class DioClient with DioMixin implements Dio {
  DioClient({BaseOptions? options, DioConfig? dioConfig}) {
    options ??= BaseOptions(
        baseUrl: dioConfig?.baseUrl ?? "",
        contentType: "application/json",
        headers: dioConfig?.headers,
        connectTimeout: dioConfig?.connectTimeout,
        sendTimeout: dioConfig?.sendTimeout,
        receiveTimeout: dioConfig?.receiveTimeout);
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
        request: false,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true));
    // 添加Cookie管理拦截器
    if (dioConfig?.cookiesPath?.isNotEmpty ?? false) {
      interceptors.add(CookieManager(
          PersistCookieJar(storage: FileStorage(dioConfig!.cookiesPath))));
    }
    // 添加配置项中的拦截器
    if (dioConfig?.interceptors?.isNotEmpty ?? false) {
      interceptors.addAll(dioConfig!.interceptors!);
    }

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  setProxy(String proxy) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        // proxy all request to localhost:8888
        return "PROXY $proxy";
      };
      return null;
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
  }
}
