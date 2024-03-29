import 'package:flutter_good_weather/bean/air_quality_bean.dart';
import 'package:flutter_good_weather/bean/bing_daily_image_bean.dart';
import 'package:flutter_good_weather/bean/disaster_warning_bean.dart';
import 'package:flutter_good_weather/bean/hourly_weather_bean.dart';
import 'package:flutter_good_weather/bean/minutely_weather_bean.dart';
import 'package:flutter_good_weather/bean/search_city_bean.dart';

import '../../bean/air_quality_forecast_bean.dart';
import '../../bean/daily_weather_bean.dart';
import '../../bean/hot_wallpaper_bean.dart';
import '../../bean/live_weather_bean.dart';
import '../../bean/living_index_bean.dart';
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

  // 手机壁纸
  static const baseUrlPicasso = "http://service.picasso.adesk.com";

  // 和风天气的KEY，请使用自己的
  static String apiKey = "8d3d5b55abb84ea5a26cbc457edd625e";

  /// 城市搜索
  /// [location] 需要查询地区的名称，支持文字、以英文逗号分隔的经度,纬度坐标（十进制，最多支持小数点后两位）、LocationID或Adcode（仅限中国城市）。
  /// 例如 location=北京 或 location=116.41,39.92
  Api.searchCity(String location, {HttpCallback<SearchCityBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(Api.baseUrlSearch).get(
      "/v2/city/lookup",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
        "range": "cn",
      },
    ).then((value) => callback?.call(SearchCityBean.fromJson(value.data)));
  }

  /// 天气灾害预警
  /// [location] 需要查询地区的LocationID或以英文逗号分隔的经度,纬度坐标（十进制，最多支持小数点后两位），LocationID可通过城市搜索服务获取。例如 location=101010100 或 location=116.41,39.92
  Api.disasterWarning(String location, {HttpCallback<DisasterWarningBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(Api.baseUrlWeather).get(
      "/v7/warning/now",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
      },
    ).then((value) => callback?.call(DisasterWarningBean.fromJson(value.data)));
  }

  /// 实时天气
  Api.liveWeatherNow(String location, {HttpCallback<LiveWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/weather/now",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
      },
    ).then((value) => callback?.call(LiveWeatherBean.fromJson(value.data)));
  }

  /// 未来2小时每5分钟降雨预报
  /// [location] 需要查询地区的以英文逗号分隔的经度,纬度坐标（十进制，最多支持小数点后两位）。例如 location=116.41,39.92
  Api.minutelyWeather(String location, {HttpCallback<MinutelyWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/minutely/5m",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
      },
    ).then((value) => callback?.call(MinutelyWeatherBean.fromJson(value.data)));
  }

  /// 逐小时天气预报 未来24小时
  Api.hourlyWeather(String location, {HttpCallback<HourlyWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/weather/24h",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
      },
    ).then((value) => callback?.call(HourlyWeatherBean.fromJson(value.data)));
  }

  /// 逐日天气预报 (免费订阅)最多可以获得7天的数据
  Api.dailyWeather(String location, {HttpCallback<DailyWeatherBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/weather/7d",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
      },
    ).then((value) => callback?.call(DailyWeatherBean.fromJson(value.data)));
  }

  /// 实时空气质量
  Api.airQualityNow(String location, {HttpCallback<AirQualityBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/air/now",
      queryParameters: {
        "key": Api.apiKey,
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
  Api.livingIndex(String location, {String days = "1d", String type = "0", HttpCallback<LivingIndexBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/indices/$days",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
        "type": type,
      },
    ).then((value) => callback?.call(LivingIndexBean.fromJson(value.data)));
  }

  /// 空气质量每日预报
  Api.airQualityForecast(String location, {HttpCallback<AirQualityForecastBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlWeather).get(
      "/v7/air/5d",
      queryParameters: {
        "key": Api.apiKey,
        "location": location,
      },
    ).then((value) => callback?.call(AirQualityForecastBean.fromJson(value.data)));
  }

  /// 热门壁纸
  /// [limit] 返回数量，默认20条，最多30条
  /// [order] 值 hot为favs， new
  /// [skip] 略过数量
  /// [adult] 布尔值，暂时未知
  /// [first] 数字，如1
  Api.hotWallpaper(
      {int limit = 30,
      int? first,
      int? skip,
      String? order = "hot",
      bool? adult,
      HttpCallback<HotWallpaperBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlPicasso).get(
      "/v1/vertical/vertical",
      queryParameters: {
        "limit": limit,
        "first": first ?? 0,
        "skip": skip ?? 0,
        "order": order ?? "hot",
        "adult": adult ?? false,
      },
    ).then((value) => callback?.call(HotWallpaperBean.fromJson(value.data)));
  }

  /// 必应每日一图
  Api.bingDailyImage({HttpCallback<BingDailyImageBean?>? callback}) {
    HttpClient.getInstance().resetBaseUrl(baseUrlBing).get(
      "/HPImageArchive.aspx?format=js&idx=0&n=1",
      queryParameters: {},
    ).then((value) => callback?.call(BingDailyImageBean.fromJson(value.data)));
  }
}
