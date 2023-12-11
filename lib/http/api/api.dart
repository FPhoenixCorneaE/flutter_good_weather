import 'package:flutter_good_weather/bean/air_quality_bean.dart';
import 'package:flutter_good_weather/bean/hourly_weather_bean.dart';
import 'package:flutter_good_weather/bean/minutely_weather_bean.dart';
import 'package:flutter_good_weather/bean/search_city_bean.dart';

import '../../bean/air_quality_forecast_bean.dart';
import '../../bean/daily_weather_bean.dart';
import '../../bean/life_index_bean.dart';
import '../../bean/live_weather_bean.dart';
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

  /// 实时天气
  Api.liveWeatherNow(String location, {HttpCallback<LiveWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/weather/now?key=${Api.apiKey}",
      queryParameters: {
        "location": location,
      },
    ).then((value) => callback?.call(LiveWeatherBean.fromJson(value.data)));
  }

  /// 未来2小时每5分钟降雨预报
  /// [location] 需要查询地区的以英文逗号分隔的经度,纬度坐标（十进制，最多支持小数点后两位）。例如 location=116.41,39.92
  Api.minutelyWeather(String location, {HttpCallback<MinutelyWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/minutely/5m?key=${Api.apiKey}",
      queryParameters: {
        "location": location,
      },
    ).then((value) => callback?.call(MinutelyWeatherBean.fromJson(value.data)));
  }

  /// 逐小时天气预报 未来24小时
  Api.hourlyWeather(String location, {HttpCallback<HourlyWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/weather/24h?key=${Api.apiKey}",
      queryParameters: {
        "location": location,
      },
    ).then((value) => callback?.call(HourlyWeatherBean.fromJson(value.data)));
  }

  /// 逐日天气预报 (免费订阅)最多可以获得7天的数据
  Api.dailyWeather(String location, {HttpCallback<DailyWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/weather/7d?key=${Api.apiKey}",
      queryParameters: {
        "location": location,
      },
    ).then((value) => callback?.call(DailyWeatherBean.fromJson(value.data)));
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

  /// 生活指数
  /// 可以控制定向获取那几项数据
  /// 全部数据 0, 运动指数	1, 洗车指数	 2, 穿衣指数 3,
  /// 钓鱼指数 4, 紫外线指数 5, 旅游指数 6, 花粉过敏指数 7, 舒适度指数 8,
  /// 感冒指数 9, 空气污染扩散条件指数	10, 空调开启指数 11, 太阳镜指数 12,
  /// 化妆指数 13, 晾晒指数 14, 交通指数 15 ，防晒指数	16
  Api.lifeIndex(String location,
      {String type = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16", HttpCallback<LifeIndexBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/indices/1d?key=${Api.apiKey}",
      queryParameters: {
        "location": location,
        "type": type,
      },
    ).then((value) => callback?.call(LifeIndexBean.fromJson(value.data)));
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
