import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/air_quality_forecast_bean.dart';
import 'package:flutter_good_weather/http/api/api.dart';
import 'package:flutter_good_weather/util/screen_util.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../bean/air_quality_bean.dart';
import '../../constant/constant.dart';
import '../../util/date_util.dart';
import '../../widget/title_bar.dart';

class MoreAirQualityPage extends StatefulWidget {
  final String adm2;
  final String location;

  const MoreAirQualityPage(this.adm2, this.location, {super.key});

  @override
  State<MoreAirQualityPage> createState() => _MoreAirQualityPageState();
}

class _MoreAirQualityPageState extends State<MoreAirQualityPage> {
  AirQualityBean? airQualityBean;
  AirQualityForecastBean? airQualityForecastBean;

  @override
  void initState() {
    super.initState();
    Api.searchCity(widget.adm2, callback: (data) {
      var locationId = data?.location?.first.id ?? "";
      Api.airQualityNow(locationId, callback: (data) {
        setState(() {
          airQualityBean = data;
        });
      });
      Api.airQualityForecast(locationId, callback: (data) {
        setState(() {
          airQualityForecastBean = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: TitleBar(
        "${widget.adm2}-${widget.location}",
        backgroundColor: Colors.transparent,
        titleColor: Colors.white,
        leftImgName: "ic_back_black.svg",
        leftImgColor: Colors.white,
        onLeftImgTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: Image(
              image: AssetImage("${Constant.assetsImages}pic_bg_home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
              top: navigationBarHeight + 12,
              bottom: 20,
              child: CustomScrollView(
                slivers: [
                  // 实时空气质量
                  buildAirQualityNow(),
                  const SliverPadding(padding: EdgeInsets.only(top: 12)),
                  // 监测站空气质量
                  buildAirQualityStation(),
                  const SliverPadding(padding: EdgeInsets.only(top: 12)),
                  // 未来5天空气质量预报
                  buildAirQualityForecast(),
                ],
              )),
        ],
      ),
    );
  }

  /// 未来5天空气质量预报
  SliverToBoxAdapter buildAirQualityForecast() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "未来5天空气质量预报",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            height: 138,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return buildAirQualityForecastItem(airQualityForecastBean?.daily?[index]);
              },
              separatorBuilder: (context, index) {
                return const VerticalDivider(width: 12, color: Colors.transparent);
              },
              itemCount: airQualityForecastBean?.daily?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }

  /// 未来5天空气质量预报item
  Container buildAirQualityForecastItem(Daily? daily) {
    var fxDate = daily?.fxDate;
    return Container(
      width: 180,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0x66000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(fxDate != null ? friendlyWeekDay(fxDate) : "",
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            Text(fxDate != null ? formatDate(DateTime.parse(fxDate), formats: ["mm", "/", "dd"]) : "",
                style: const TextStyle(color: Colors.white, fontSize: 14)),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Center(child: Text("AQI指数", style: TextStyle(color: Colors.white, fontSize: 14))),
                ),
                Expanded(
                  flex: 1,
                  child:
                      Center(child: Text(daily?.aqi ?? "", style: const TextStyle(color: Colors.white, fontSize: 14))),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Center(child: Text("空气质量", style: TextStyle(color: Colors.white, fontSize: 14))),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                      child: Text(daily?.category ?? "", style: const TextStyle(color: Colors.white, fontSize: 14))),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Center(child: Text("污染物", style: TextStyle(color: Colors.white, fontSize: 14))),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "NA" == daily?.primary ? "无污染" : daily?.primary ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 监测站空气质量
  SliverToBoxAdapter buildAirQualityStation() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "监测站空气质量",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          // 监测站点
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SizedBox(
              width: double.infinity,
              height: 238,
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                    ),
                    child: buildAirQualityStationItem(airQualityBean?.station?[index]),
                  );
                },
                itemCount: airQualityBean?.station?.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 监测站item
  Container buildAirQualityStationItem(Station? station) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0x66000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              station?.name ?? "",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            buildAirQualityStationContentItem("空气质量", station?.category ?? ""),
            buildAirQualityStationContentItem("空气质量指数", station?.aqi ?? ""),
            buildAirQualityStationContentItem("污染物", "NA" == station?.primary ? "无污染" : station?.primary ?? ""),
            buildAirQualityStationContentItem("pm10", station?.pm10 ?? ""),
            buildAirQualityStationContentItem("pm2.5", station?.pm2p5 ?? ""),
            buildAirQualityStationContentItem("二氧化氮", station?.no2 ?? ""),
            buildAirQualityStationContentItem("二氧化硫", station?.so2 ?? ""),
            buildAirQualityStationContentItem("臭氧", station?.o3 ?? ""),
            buildAirQualityStationContentItem("一氧化碳", station?.co ?? ""),
          ],
        ),
      ),
    );
  }

  /// 监测站内容item
  Row buildAirQualityStationContentItem(String name, String value) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                name,
                style: const TextStyle(color: Color(0xff9FC8E9), fontSize: 12),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ]);
  }

  /// 实时空气质量
  SliverToBoxAdapter buildAirQualityNow() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0x66000000),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "实时空气质量",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "上次更新时间：${divideTime(updateTime(airQualityBean?.updateTime))}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              Container(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 污染指数
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "污染指数",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 1,
                        child: Divider(
                          color: Colors.transparent,
                          thickness: 8,
                        ),
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
                            progressBarColors: [Colors.pink, Colors.yellow, Colors.blue],
                            shadowColor: Colors.white,
                            shadowMaxOpacity: 0.05,
                            dotColor: Colors.transparent,
                          ),
                          infoProperties: InfoProperties(
                            // 空气质量描述 取值范围：优，良，轻度污染，中度污染，重度污染，严重污染
                            topLabelText: airQualityBean?.now?.category,
                            topLabelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                            mainLabelStyle:
                                const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
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
                        max: 300,
                        // 当前进度
                        initialValue: double.parse(airQualityBean?.now?.aqi ?? "0"),
                      )
                    ],
                  ),
                  // 空气质量指标
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // PM10
                      buildAirQualityNowItem(
                        "PM10",
                        airQualityBean?.now?.pm10,
                      ),
                      // PM2.5
                      buildAirQualityNowItem(
                        "PM2.5",
                        airQualityBean?.now?.pm2p5,
                      ),
                      // NO₂
                      buildAirQualityNowItem(
                        "NO₂",
                        airQualityBean?.now?.no2,
                      ),
                      // SO₂
                      buildAirQualityNowItem(
                        "SO₂",
                        airQualityBean?.now?.so2,
                      ),
                      // O₃
                      buildAirQualityNowItem(
                        "O₃",
                        airQualityBean?.now?.o3,
                      ),
                      // CO
                      buildAirQualityNowItem(
                        "CO",
                        airQualityBean?.now?.co,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 实时空气质量指标item
  Widget buildAirQualityNowItem(String airQualityTitle, String? airQualityValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            child: Center(
              child: Text(
                airQualityTitle,
                style: const TextStyle(color: Color(0xff9FC8E9), fontSize: 12),
              ),
            ),
          ),
          SizedBox(
            width: 120,
            height: 8,
            child: LinearProgressIndicator(
              backgroundColor: const Color(0xffC6D7F4),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              valueColor: const AlwaysStoppedAnimation(Colors.red),
              value: double.parse(airQualityValue ?? "0") / 100,
            ),
          ),
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                airQualityValue ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
