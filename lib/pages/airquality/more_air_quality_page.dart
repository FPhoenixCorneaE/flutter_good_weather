import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/air_quality_forecast_bean.dart';
import 'package:flutter_good_weather/http/api/api.dart';
import 'package:flutter_good_weather/util/screen_util.dart';
import 'package:flutter_good_weather/widget/wallpaper_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      ),
      body: Stack(
        children: <Widget>[
          const Positioned.fill(child: WallpaperImage()),
          Positioned.fill(
              top: navigationBarHeight + 12.h,
              bottom: 20.h,
              child: CustomScrollView(
                slivers: [
                  // 实时空气质量
                  buildAirQualityNow(),
                  SliverPadding(padding: EdgeInsets.only(top: 12.h)),
                  // 监测站空气质量
                  buildAirQualityStation(),
                  SliverPadding(padding: EdgeInsets.only(top: 12.h)),
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
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              "未来5天空气质量预报",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            width: double.infinity,
            height: 138.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return buildAirQualityForecastItem(airQualityForecastBean?.daily?[index]);
              },
              separatorBuilder: (context, index) {
                return VerticalDivider(width: 12.w, color: Colors.transparent);
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
      width: 180.w,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0x66000000),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(fxDate != null ? friendlyWeekDay(fxDate) : "", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
            Text(fxDate != null ? formatDate(DateTime.parse(fxDate), formats: ["mm", "/", "dd"]) : "",
                style: TextStyle(color: Colors.white, fontSize: 14.sp)),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(child: Text("AQI指数", style: TextStyle(color: Colors.white, fontSize: 14.sp))),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text(daily?.aqi ?? "", style: TextStyle(color: Colors.white, fontSize: 14.sp))),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(child: Text("空气质量", style: TextStyle(color: Colors.white, fontSize: 14.sp))),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                      child: Text(daily?.category ?? "", style: TextStyle(color: Colors.white, fontSize: 14.sp))),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(child: Text("污染物", style: TextStyle(color: Colors.white, fontSize: 14.sp))),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "NA" == daily?.primary ? "无污染" : daily?.primary ?? "",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
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
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              "监测站空气质量",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 8.h),
          // 监测站点
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: SizedBox(
              width: double.infinity,
              height: 238.h,
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
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
      height: 200.h,
      decoration: BoxDecoration(
        color: const Color(0x66000000),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              station?.name ?? "",
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
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
                style: TextStyle(color: Color(0xff9FC8E9), fontSize: 12.sp),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ),
        ]);
  }

  /// 实时空气质量
  SliverToBoxAdapter buildAirQualityNow() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0x66000000),
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "实时空气质量",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  Text(
                    "上次更新时间：${divideTime(updateTime(airQualityBean?.updateTime))}",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 污染指数
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "污染指数",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      SizedBox(height: 8.h),
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                            trackWidth: 8.w,
                            progressBarWidth: 8.w,
                            shadowWidth: 20.w,
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
                            topLabelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            mainLabelStyle:
                                TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.w400),
                            modifier: (value) {
                              return "${value.toInt()}";
                            },
                          ),
                          startAngle: 135,
                          angleRange: 270,
                          size: 0.25.sw,
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
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 48.w,
            child: Center(
              child: Text(
                airQualityTitle,
                style: TextStyle(color: const Color(0xff9FC8E9), fontSize: 12.sp),
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            height: 8.h,
            child: LinearProgressIndicator(
              backgroundColor: const Color(0xffC6D7F4),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.w)),
              valueColor: const AlwaysStoppedAnimation(Colors.red),
              value: double.parse(airQualityValue ?? "0") / 100,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Center(
              child: Text(
                airQualityValue ?? "",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
