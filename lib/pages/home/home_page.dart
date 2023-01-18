import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/daily_weather_bean.dart';
import 'package:flutter_good_weather/bean/hourly_weather_bean.dart';
import 'package:flutter_good_weather/bean/live_weather_bean.dart';
import 'package:flutter_good_weather/bean/search_city_bean.dart';
import 'package:flutter_good_weather/http/api/api.dart';
import 'package:flutter_good_weather/http/http_client.dart';
import 'package:flutter_good_weather/util/date_util.dart';
import 'package:flutter_good_weather/util/weather_util.dart';
import 'package:flutter_good_weather/widget/title_bar.dart';

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
}
