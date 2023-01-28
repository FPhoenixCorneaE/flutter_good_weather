import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/air_quality_bean.dart';
import 'package:flutter_good_weather/bean/daily_weather_bean.dart';
import 'package:flutter_good_weather/bean/hourly_weather_bean.dart';
import 'package:flutter_good_weather/bean/live_weather_bean.dart';
import 'package:flutter_good_weather/bean/search_city_bean.dart';
import 'package:flutter_good_weather/http/api/api.dart';
import 'package:flutter_good_weather/http/http_client.dart';
import 'package:flutter_good_weather/util/date_util.dart';
import 'package:flutter_good_weather/util/weather_util.dart';
import 'package:flutter_good_weather/widget/title_bar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../constant/constant.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? cityName = "北京";
  SearchCityBean? searchCityBean;
  LiveWeatherBean? liveWeatherBean;
  HourlyWeatherBean? hourlyWeatherBean;
  DailyWeatherBean? dailyWeatherBean;
  AirQualityBean? airQualityBean;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: TitleBar(
        cityName ?? "城市天气",
        imgName: "ic_add.svg",
      ),
      body: RefreshIndicator(
        displacement: 120,
        onRefresh: _onRefresh,
        child: Stack(
          children: <Widget>[
            const Positioned.fill(
                child: Image(
              image: AssetImage("${Constant.assetsImages}pic_bg_home.jpg"),
              fit: BoxFit.cover,
            )),
            Container(
              margin: const EdgeInsets.only(top: 120),
              child: CustomScrollView(
                // 是否根据正在查看的内容确定滚动视图的范围
                shrinkWrap: false,
                // 内容
                slivers: <Widget>[
                  // 实时天气
                  buildWeatherCondition(),
                  // 逐小时天气预报列表
                  buildHourlyWeather(),
                  // 逐日天气预报列表
                  buildDailyWeather(),
                  // 空气质量
                  buildAirQuality(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 实时天气
  SliverToBoxAdapter buildWeatherCondition() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          // 星期几
          Positioned(
              left: 20,
              top: 8,
              child: Text(
                getTodayOfWeek(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              )),
          // 温度
          Align(
            alignment: FractionalOffset.topCenter,
            child: Row(
              // 主轴(就是水平方向)对齐方式
              mainAxisAlignment: MainAxisAlignment.center,
              // 交叉轴(就是垂直方向)对齐方式
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 8, right: 8),
                    child: Text(
                      liveWeatherBean?.now?.temp ?? "",
                      style: const TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 摄氏度符号
                    const Text(
                      "℃",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    // 天气状况
                    Text(
                      liveWeatherBean?.now?.text ?? "",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          // 当天最高温和最低温
          Align(
              alignment: FractionalOffset.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                child: Text(
                  "${dailyWeatherBean?.daily?.first.tempMax}℃/${dailyWeatherBean?.daily?.first.tempMin}℃",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 148, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Image(
                            width: 20,
                            height: 20,
                            image: AssetImage(
                                "${Constant.assetsImages}ic_weather_sun.png")),
                        Text(
                          "好天气",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                    Text(
                      "最近更新时间：${divideTime(updateTime(liveWeatherBean?.updateTime))}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
          // 分割线
          Container(
            margin: const EdgeInsets.only(left: 20, top: 180, right: 20),
            child: const Divider(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  /// 逐小时天气预报列表
  SliverToBoxAdapter buildHourlyWeather() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 12, right: 20),
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: hourlyWeatherBean?.hourly?.length ?? 0,
          itemBuilder: (context, index) {
            // 子条目的布局样式
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 时间
                Text(
                  divideTime(
                      updateTime(hourlyWeatherBean?.hourly?[index].fxTime)),
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                // 气候图标
                Image(
                    width: 32,
                    height: 32,
                    image: AssetImage(
                        "${Constant.assetsImages}${getWeatherIconName(int.tryParse(hourlyWeatherBean?.hourly?[index].icon ?? ""))}")),
                // 温度
                Text(
                  "${hourlyWeatherBean?.hourly?[index].temp}℃",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            );
          },
          // 设置Item项间距
          separatorBuilder: (context, index) {
            return const VerticalDivider(
              width: 20,
              color: Colors.transparent,
            );
          },
        ),
      ),
    );
  }

  /// 逐日天气预报列表
  SliverFixedExtentList buildDailyWeather() {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 20, top: 12, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 时间
                Text(
                  dailyWeatherBean?.daily?[index].fxDate ?? "",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                // 气候图标
                Image(
                    width: 32,
                    height: 32,
                    image: AssetImage(
                        "${Constant.assetsImages}${getWeatherIconName(int.tryParse(dailyWeatherBean?.daily?[index].iconDay ?? ""))}")),
                // 温度
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${dailyWeatherBean?.daily?[index].tempMax}℃/${dailyWeatherBean?.daily?[index].tempMin}℃",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }, childCount: 7),
        itemExtent: 48);
  }

  /// 空气质量
  SliverToBoxAdapter buildAirQuality() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 8),
            child: const Text(
              "空气质量",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "污染指数",
                      style: TextStyle(
                          color: Colors.white, fontSize: 14),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      thickness: 8,
                    ),
                    SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                          trackWidth: 8,
                          progressBarWidth: 8,
                          shadowWidth: 20,
                        ),
                        customColors: CustomSliderColors(
                          trackColor: Colors.grey,
                          progressBarColors: [
                            Colors.pink,
                            Colors.yellow,
                            Colors.blue
                          ],
                          shadowColor: Colors.white,
                          shadowMaxOpacity: 0.05,
                          dotColor: Colors.transparent,
                        ),
                        infoProperties: InfoProperties(
                          // 空气质量描述 取值范围：优，良，轻度污染，中度污染，重度污染，严重污染
                          topLabelText:
                          airQualityBean?.now?.category,
                          topLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                          mainLabelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w400),
                          modifier: (value) {
                            return "${value.toInt()}";
                          },
                        ),
                        startAngle: 135,
                        angleRange: 270,
                        size: 120,
                        animationEnabled: true,
                      ),
                      min: 0,
                      max: 100,
                      // 当前进度
                      initialValue: double.parse(
                          airQualityBean?.now?.aqi ?? "0"),
                    )
                  ],
                ),
                SizedBox(
                  height: 138,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "PM10",
                        style: TextStyle(
                            color: Color(0xff9FC8E9),
                            fontSize: 12),
                      ),
                      Text(
                        "PM2.5",
                        style: TextStyle(
                            color: Color(0xff9FC8E9),
                            fontSize: 12),
                      ),
                      Text(
                        "NO₂",
                        style: TextStyle(
                            color: Color(0xff9FC8E9),
                            fontSize: 12),
                      ),
                      Text(
                        "SO₂",
                        style: TextStyle(
                            color: Color(0xff9FC8E9),
                            fontSize: 12),
                      ),
                      Text(
                        "O₃",
                        style: TextStyle(
                            color: Color(0xff9FC8E9),
                            fontSize: 12),
                      ),
                      Text(
                        "CO",
                        style: TextStyle(
                            color: Color(0xff9FC8E9),
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 138,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // PM10
                      Text(
                        airQualityBean?.now?.pm10 ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                      // PM2.5
                      Text(
                        airQualityBean?.now?.pm2p5 ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                      // 二氧化氮
                      Text(
                        airQualityBean?.now?.no2 ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                      // 二氧化硫
                      Text(
                        airQualityBean?.now?.so2 ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                      // 臭氧
                      Text(
                        airQualityBean?.now?.o3 ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                      // 一氧化碳
                      Text(
                        airQualityBean?.now?.co ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    return Future.delayed(const Duration(seconds: 2), () {
      // 搜索城市
      searchCity();
    });
  }

  @override
  void initState() {
    super.initState();

    // 搜索城市
    searchCity();
  }

  /// 搜索城市  模糊搜索，国内范围 返回10条数据
  void searchCity() {
    if (cityName == null) {
      return;
    }
    HttpClient.getInstance()
        .resetBaseUrl(Api.baseUrlSearch)
        .get("/v2/city/lookup?key=${Api.apiKey}&range=cn", queryParameters: {
      "location": cityName,
    }).then((value) {
      setState(() {
        searchCityBean = SearchCityBean.fromJson(value.data);
      });
      // 城市id
      var id = searchCityBean?.location?.first.id;
      if (id != null) {
        // 实时天气
        liveWeatherNow(id);
        // 逐小时天气预报
        hourlyWeather(id);
        // 逐日天气预报
        dailyWeather(id);
        // 当天空气质量
        airQuality(id);
      }
    });
  }

  /// 实时天气
  void liveWeatherNow(String id) {
    HttpClient.getInstance()
        .resetBaseUrl(Api.baseUrlWeather)
        .get("/v7/weather/now?key=${Api.apiKey}", queryParameters: {
      "location": id,
    }).then((value) {
      setState(() {
        liveWeatherBean = LiveWeatherBean.fromJson(value.data);
      });
    });
  }

  /// 逐小时天气预报 未来24小时
  void hourlyWeather(String id) {
    HttpClient.getInstance()
        .get("/v7/weather/24h?key=${Api.apiKey}", queryParameters: {
      "location": id,
    }).then((value) {
      setState(() {
        hourlyWeatherBean = HourlyWeatherBean.fromJson(value.data);
      });
    });
  }

  /// 逐日天气预报 (免费订阅)最多可以获得7天的数据
  void dailyWeather(String id) {
    HttpClient.getInstance()
        .get("/v7/weather/7d?key=${Api.apiKey}", queryParameters: {
      "location": id,
    }).then((value) {
      setState(() {
        dailyWeatherBean = DailyWeatherBean.fromJson(value.data);
      });
    });
  }

  /// 当天空气质量
  void airQuality(String id) {
    HttpClient.getInstance()
        .get("/v7/air/now?key=${Api.apiKey}", queryParameters: {
      "location": id,
    }).then((value) {
      setState(() {
        airQualityBean = AirQualityBean.fromJson(value.data);
      });
    });
  }
}
