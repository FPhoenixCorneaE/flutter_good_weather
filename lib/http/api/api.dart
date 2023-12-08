import 'package:flutter_good_weather/bean/air_quality_bean.dart';
import 'package:flutter_good_weather/bean/search_city_bean.dart';

import '../../bean/air_quality_forecast_bean.dart';
import '../http_client.dart';

typedef HttpCallback<T> = void Function(T result);

/// Api
class Api {
  // 和风天气搜索城市
  static const baseUrlSearch = "https://geoapi.qweather.com";

  // 和风天气
  static const baseUrlWeather = "https://devapi.qweather.com";

  // 必应壁纸
  static const baseUrlBing = "https://cn.bing.com";

  // 和风天气的KEY，请使用自己的
  static String apiKey = "8d3d5b55abb84ea5a26cbc457edd625e";

  /// 城市搜索
  /// [location] 需要查询地区的名称，支持文字、以英文逗号分隔的经度,纬度坐标（十进制，最多支持小数点后两位）、LocationID或Adcode（仅限中国城市）。
  /// 例如 location=北京 或 location=116.41,39.92
  Api.searchCity(String location, {HttpCallback<SearchCityBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(Api.baseUrlSearch).get(
      "/v2/city/lookup?key=${Api.apiKey}&range=cn",
      queryParameters: {
        "location": location,
      },
    ).then((value) => callback?.call(SearchCityBean.fromJson(value.data)));
  }

  /// 实时空气质量
  Api.airQualityNow(String location, {HttpCallback<AirQualityBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/air/now?key=${Api.apiKey}",
      queryParameters: {
        "location": location,
      },
    ).then((value) => callback?.call(AirQualityBean.fromJson(value.data)));
  }

  /// 空气质量每日预报
  Api.airQualityForecast(String location, {HttpCallback<AirQualityForecastBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/air/5d?key=${Api.apiKey}",
      queryParameters: {
        "location": location,
      },
    ).then((value) => callback?.call(AirQualityForecastBean.fromJson(value.data)));
  }
}
