import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'dio_client.dart';
import 'dio_config.dart';
import 'http_exception.dart';
import 'http_response.dart';
import 'transformer/default_http_transformer.dart';
import 'transformer/http_transformer.dart';

/// 采用 Restful 标准，创建对应的请求方法
class HttpClient {
  late final DioClient _dio;

  /// 单例对象，为了避免多次创建实例
  static HttpClient? _instance;

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  HttpClient._internal({BaseOptions? options, DioConfig? dioConfig})
      : _dio = DioClient(options: options, dioConfig: dioConfig);

  static HttpClient getInstance({String? baseUrl, BaseOptions? options, DioConfig? dioConfig}) {
    _instance ??= HttpClient._internal(options: options, dioConfig: dioConfig);
    return _instance!;
  }

  HttpClient resetBaseUrl(String? baseUrl) {
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  /// get
  Future<HttpResponse> get(String uri,
      {Map<String, dynamic>? queryParameters,
      bool isShowLoading = true,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowLoading) {
        showLoading();
      }
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    } finally {
      dismissLoading();
    }
  }

  /// post
  Future<HttpResponse> post(String uri,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isShowLoading = true,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowLoading) {
        showLoading();
      }
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    } finally {
      dismissLoading();
    }
  }

  /// patch
  Future<HttpResponse> patch(String uri,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isShowLoading = true,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowLoading) {
        showLoading();
      }
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    } finally {
      dismissLoading();
    }
  }

  /// delete
  Future<HttpResponse> delete(String uri,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isShowLoading = true,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowLoading) {
        showLoading();
      }
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    } finally {
      dismissLoading();
    }
  }

  /// put
  Future<HttpResponse> put(String uri,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isShowLoading = true,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowLoading) {
        showLoading();
      }
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    } finally {
      dismissLoading();
    }
  }

  /// download
  /// [isImage] true为图片，false为文件
  Future<Map<Object?, Object?>?> download(String url, String savePath,
      {bool isImage = true,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      Object? data,
      ProgressCallback? onReceiveProgress,
      bool isReturnPathOfIOS = false}) async {
    try {
      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
        data: data,
        options: options ??
            Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                validateStatus: (status) {
                  return status != null && status < 500;
                }),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      final dynamic result;
      if (isImage) {
        result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100);
      } else {
        result = await ImageGallerySaver.saveFile(savePath);
      }
      return result;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        EasyLoading.showToast("下载已取消！");
      } else {
        EasyLoading.showError(e.message ?? "");
      }
      return null;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}

void showLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    // More indicatorType can see in 👉 flutter_spinkit showcase: https://github.com/jogboms/flutter_spinkit#-showcase
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60.w
    ..radius = 20.w
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.5)
    ..indicatorColor = Colors.blue
    ..textColor = Colors.white
    ..textStyle = TextStyle(color: Colors.white, fontSize: 20.sp)
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  EasyLoading.show(status: "加载中...");
}

void dismissLoading() {
  EasyLoading.dismiss();
}

HttpResponse handleResponse(Response? response, {HttpTransformer? httpTransformer}) {
  httpTransformer ??= DefaultHttpTransformer.getInstance();

  // 返回值异常
  if (response == null) {
    return HttpResponse.failureFromError();
  }

  // token失效
  if (_isTokenTimeout(response.statusCode)) {
    return HttpResponse.failureFromError(UnauthorisedException(message: "没有权限", code: response.statusCode));
  }
  // 接口调用成功
  if (_isRequestSuccess(response.statusCode)) {
    return httpTransformer.parse(response);
  } else {
    // 接口调用失败
    return HttpResponse.failure(errorMsg: response.statusMessage, errorCode: response.statusCode);
  }
}

HttpResponse handleException(Exception exception) {
  var parseException = _parseException(exception);
  return HttpResponse.failureFromError(parseException);
}

/// 鉴权失败
bool _isTokenTimeout(int? code) {
  return code == 401;
}

/// 请求成功
bool _isRequestSuccess(int? statusCode) {
  return (statusCode != null && statusCode == 200);
}

/// 自定义错误状态码
/// 和风天气接口返回的错误状态码处理
HttpException _parseException(Exception error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(message: error.message);
      case DioExceptionType.cancel:
        return CancelException(error.message);
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        try {
          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 204:
              return BadRequestException(message: "请求成功，但你查询的地区暂时没有你需要的数据。", code: errCode);
            case 400:
              return BadRequestException(message: "请求错误，可能包含错误的请求参数或缺少必选的请求参数。", code: errCode);
            case 401:
              return UnauthorisedException(
                  message: "认证失败，可能使用了错误的KEY、数字签名错误、KEY的类型错误（如使用SDK的KEY去访问Web API）。", code: errCode);
            case 402:
              return UnauthorisedException(message: "超过访问次数或余额不足以支持继续访问服务，你可以充值、升级访问量或等待访问量重置。", code: errCode);
            case 403:
              return BadRequestException(
                  message: "无访问权限，可能是绑定的PackageName、BundleID、域名IP地址不一致，或者是需要额外付费的数据。", code: errCode);
            case 404:
              return BadRequestException(message: "查询的数据或地区不存在。", code: errCode);
            case 429:
              return BadRequestException(message: "超过限定的QPM（每分钟访问次数），请参考QPM说明", code: errCode);
            case 500:
              return BadServiceException(message: "无响应或超时，接口服务异常请联系我们", code: errCode);
            default:
              return UnknownException(error.message);
          }
        } on Exception catch (_) {
          return UnknownException(error.message);
        }

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NetworkException(message: error.message);
        } else {
          return UnknownException(error.message);
        }
      default:
        return UnknownException(error.message);
    }
  } else {
    return UnknownException(error.toString());
  }
}
