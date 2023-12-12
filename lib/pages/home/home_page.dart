import 'dart:math';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/air_quality_bean.dart';
import 'package:flutter_good_weather/bean/daily_weather_bean.dart';
import 'package:flutter_good_weather/bean/hourly_weather_bean.dart';
import 'package:flutter_good_weather/bean/life_index_bean.dart';
import 'package:flutter_good_weather/bean/live_weather_bean.dart';
import 'package:flutter_good_weather/bean/minutely_weather_bean.dart';
import 'package:flutter_good_weather/bean/search_city_bean.dart';
import 'package:flutter_good_weather/http/api/api.dart';
import 'package:flutter_good_weather/meta/province.dart';
import 'package:flutter_good_weather/navi.dart';
import 'package:flutter_good_weather/pages/home/daily_detail_dialog.dart';
import 'package:flutter_good_weather/pages/home/hourly_detail_dialog.dart';
import 'package:flutter_good_weather/util/date_util.dart';
import 'package:flutter_good_weather/util/screen_util.dart';
import 'package:flutter_good_weather/util/weather_util.dart';
import 'package:flutter_good_weather/widget/icon_text.dart';
import 'package:flutter_good_weather/widget/popup.dart';
import 'package:flutter_good_weather/widget/title_bar.dart';
import 'package:flutter_good_weather/widget/windmills.dart';
import 'package:flutter_good_weather/widget/zoom_in_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../constant/constant.dart';
import '../../util/log_util.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? cityName = "东城区";

  // 获取空气质量监测站数据会用到
  String? adm2;
  SearchCityBean? searchCityBean;
  LiveWeatherBean? liveWeatherBean;
  MinutelyWeatherBean? minutelyWeatherBean;
  HourlyWeatherBean? hourlyWeatherBean;
  DailyWeatherBean? dailyWeatherBean;
  AirQualityBean? airQualityBean;
  LifeIndexBean? lifeIndexBean;
  Function? cityDialogCloseFunction;
  Result? cityResult;
  bool isExpandedPrecip = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: TitleBar(
        cityName ?? "城市天气",
        rightImgName: "ic_round_location_24.svg",
        rightImg2Name: "ic_add.svg",
        onRightImgTap: () {
          // 定位
          location();
        },
        onRightImg2Tap: () {
          // 显示城市弹窗
          showCityDialog(context);
        },
      ),
      body: RefreshIndicator(
        displacement: 120.h,
        onRefresh: _onRefresh,
        child: Stack(
          children: <Widget>[
            const Positioned.fill(
              child: Image(
                image: AssetImage("${Constant.assetsImages}pic_bg_home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: navigationBarHeight),
              child: CustomScrollView(
                // 是否根据正在查看的内容确定滚动视图的范围
                shrinkWrap: false,
                // 内容
                slivers: <Widget>[
                  SliverPadding(padding: EdgeInsets.only(top: 20.h)),
                  // 实时天气
                  buildWeatherCondition(),
                  // 未来2小时每5分钟降雨预报
                  buildMinutelyWeather(),
                  // 逐小时天气预报列表
                  buildHourlyWeather(),
                  // 逐日天气预报列表
                  buildDailyWeather(),
                  // 空气质量
                  buildAirQuality(),
                  // 风向风力风速
                  buildWindBox(),
                  // 生活指数
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "生活指数",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                  SliverPadding(padding: EdgeInsets.only(top: 8.h)),
                  buildLifeIndex(),
                  SliverPadding(padding: EdgeInsets.only(top: 20.h)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 定位
  void location() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      bool serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return;
      }
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Geolocator.openAppSettings();
      return;
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true);
    LogUtil.d("定位成功：$position");
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    LogUtil.d("定位成功：$placemark");
    switchCity(placemark[0].subLocality);
  }

  /// 显示城市弹窗
  void showCityDialog(BuildContext context) {
    // 弹窗宽度
    double dialogWidth = 120;
    // 弹窗每项高度
    double cellHeight = 40;
    double upArrowHeight = 8;
    List dataList = ["切换城市", "管理城市", "必应壁纸"];
    Navigator.push(
      context,
      Popup(
        child: ZoomInDialog(
          right: 10,
          top: navigationBarHeight - 10,
          offset: Offset(dialogWidth / 2, -(cellHeight * dataList.length + upArrowHeight) / 2),
          fun: (close) {
            cityDialogCloseFunction = close;
          },
          child: SizedBox(
            width: dialogWidth,
            height: cellHeight * dataList.length + upArrowHeight,
            child: Stack(
              children: [
                // 三角形
                Positioned(
                  right: sqrt(pow(upArrowHeight, 2) * 2),
                  child: Container(
                    width: upArrowHeight * 2,
                    height: upArrowHeight * 2,
                    transform: Matrix4.rotationZ(pi / 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // 菜单内容
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: dialogWidth,
                    height: cellHeight * dataList.length,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: ListView.separated(
                      itemCount: dataList.length,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          child: InkWell(
                            onTap: () async {
                              await cityDialogCloseFunction?.call();
                              if (!mounted) {
                                return;
                              }
                              if (index == 0) {
                                // 切换城市
                                Result? result = await CityPickers.showCityPicker(
                                  context: context,
                                  theme: ThemeData.light(useMaterial3: true),
                                  locationCode: cityResult?.areaId ?? "110000",
                                  // 顶部圆角值
                                  borderRadius: 8,
                                  // 显示省市区
                                  showType: ShowType.pca,
                                  citiesData: cityDatas,
                                  provincesData: provinceDatas,
                                );
                                cityResult = result;
                                switchCity(result?.areaName);
                              } else if (index == 1) {
                                // 管理城市
                                var result = await Navi().pushForResult(
                                  context,
                                  Navi.manageCityPage,
                                );
                                if (result != null) {
                                  switchCity(result);
                                }
                              }
                            },
                            child: Container(
                              height: cellHeight,
                              alignment: Alignment.center,
                              child: Text(
                                dataList[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(height: .1, indent: 50, endIndent: 0, color: Color(0xFFE6E6E6)),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              left: 20.w,
              top: 8.h,
              child: Text(
                getTodayOfWeek(),
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
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
                    margin: EdgeInsets.only(top: 8.h, right: 8.w),
                    child: Text(
                      liveWeatherBean?.now?.temp ?? "",
                      style: TextStyle(fontSize: 60.sp, color: Colors.white, fontWeight: FontWeight.w400),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 摄氏度符号
                    Text(
                      "℃",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                    // 天气状况
                    Text(
                      liveWeatherBean?.now?.text ?? "",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
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
                margin: EdgeInsets.only(top: 100.h),
                child: Text(
                  "${dailyWeatherBean?.daily?.first.tempMax ?? "-"}℃/${dailyWeatherBean?.daily?.first.tempMin ?? "-"}℃",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 20.w, top: 148.h, right: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                            width: 20.w,
                            height: 20.w,
                            image: const AssetImage("${Constant.assetsImages}ic_weather_sun.png")),
                        SizedBox(width: 4.w),
                        Text(
                          "好天气",
                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        )
                      ],
                    ),
                    Text(
                      "最近更新时间：${divideTime(updateTime(liveWeatherBean?.updateTime))}",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    )
                  ],
                )
              ],
            ),
          ),
          // 分割线
          Container(
            margin: EdgeInsets.only(left: 20.w, top: 180.h, right: 20.w),
            child: Divider(color: Colors.white, thickness: 0.5.h),
          ),
        ],
      ),
    );
  }

  /// 未来2小时每5分钟降雨预报
  SliverToBoxAdapter buildMinutelyWeather() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconText(
                  minutelyWeatherBean?.summary,
                  icon: SvgPicture.asset(
                    "${Constant.assetsSvg}ic_rain.svg",
                    width: 16.w,
                    height: 16.w,
                  ),
                  padding: EdgeInsets.all(4.w),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                IconText(
                  "查看详情",
                  icon: RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      "${Constant.assetsSvg}ic_back_black.svg",
                      width: 16.w,
                      height: 16.w,
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  afterIcon: false,
                  onTap: () {
                    setState(() {
                      isExpandedPrecip = !isExpandedPrecip;
                    });
                  },
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Container(
                margin: EdgeInsets.only(top: 8.h),
                width: double.infinity,
                height: 120.h,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: minutelyWeatherBean?.minutely?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // 列数
                    crossAxisCount: 2,
                    // 主轴方向上的空隙间距
                    mainAxisSpacing: 8.w,
                    // 次轴方向上的空隙间距
                    crossAxisSpacing: 0.h,
                    childAspectRatio: 0.88,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          divideTime(updateTime(minutelyWeatherBean?.minutely?[index].fxTime)),
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${minutelyWeatherBean?.minutely?[index].precip ?? ""}  ${minutelyWeatherBean?.minutely?[index].type == "snow" ? "雪" : "雨"}",
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        )
                      ],
                    );
                  },
                ),
              ),
              crossFadeState: isExpandedPrecip ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 400),
            ),
            // 分割线
            Divider(color: Colors.white, thickness: 0.5.h),
          ],
        ),
      ),
    );
  }

  /// 逐小时天气预报列表
  SliverToBoxAdapter buildHourlyWeather() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        height: 100.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: hourlyWeatherBean?.hourly?.length ?? 0,
          itemBuilder: (context, index) {
            // 子条目的布局样式
            return Material(
              // 背景色
              color: Colors.transparent,
              child: InkWell(
                // shape圆角半径
                borderRadius: BorderRadius.circular(8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 时间
                    Text(
                      divideTime(updateTime(hourlyWeatherBean?.hourly?[index].fxTime)),
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    // 气候图标
                    Image(
                        width: 32.w,
                        height: 32.w,
                        image: AssetImage(
                            "${Constant.assetsImages}${getWeatherIconName(int.tryParse(hourlyWeatherBean?.hourly?[index].icon ?? ""))}")),
                    // 温度
                    Text(
                      "${hourlyWeatherBean?.hourly?[index].temp}℃",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  // 显示逐小时预报详情弹窗
                  showCupertinoDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return HourlyDetailDialog(hourlyWeatherBean?.hourly?[index]);
                    },
                  );
                },
              ),
            );
          },
          // 设置Item项间距
          separatorBuilder: (context, index) {
            return VerticalDivider(
              width: 20.w,
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
          final fxDate = dailyWeatherBean?.daily?[index].fxDate ?? "";
          String friendlyTime = "$fxDate ${getDayOfWeek(fxDate)}";
          return Container(
            margin: EdgeInsets.only(left: 20.w, top: 12.h, right: 20.w),
            child: Material(
              // 背景色
              color: Colors.transparent,
              child: InkWell(
                // shape圆角半径
                borderRadius: BorderRadius.circular(8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 时间
                    Text(
                      friendlyTime,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    // 气候图标
                    Image(
                        width: 32.w,
                        height: 32.w,
                        image: AssetImage(
                            "${Constant.assetsImages}${getWeatherIconName(int.tryParse(dailyWeatherBean?.daily?[index].iconDay ?? ""))}")),
                    // 温度
                    Container(
                      width: 100.w,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${dailyWeatherBean?.daily?[index].tempMax ?? "-"}℃/${dailyWeatherBean?.daily?[index].tempMin ?? "-"}℃",
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // 显示逐日预报详情弹窗
                  showCupertinoDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return DailyDetailDialog(dailyWeatherBean?.daily?[index]);
                    },
                  );
                },
              ),
            ),
          );
        }, childCount: 7),
        itemExtent: 48.h);
  }

  /// 空气质量
  SliverToBoxAdapter buildAirQuality() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "空气质量",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                IconText(
                  "更多",
                  icon: RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      "${Constant.assetsSvg}ic_back_black.svg",
                      width: 16.w,
                      height: 16.w,
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  afterIcon: false,
                  onTap: () {
                    Navi.push(
                      context,
                      Navi.moreAirQualityPage,
                      params: {"adm2": adm2, "location": cityName},
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                        mainLabelStyle: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.w400),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 138.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "PM10",
                          style: TextStyle(color: const Color(0xff9FC8E9), fontSize: 12.sp),
                        ),
                        Text(
                          "PM2.5",
                          style: TextStyle(color: const Color(0xff9FC8E9), fontSize: 12.sp),
                        ),
                        Text(
                          "NO₂",
                          style: TextStyle(color: const Color(0xff9FC8E9), fontSize: 12.sp),
                        ),
                        Text(
                          "SO₂",
                          style: TextStyle(color: const Color(0xff9FC8E9), fontSize: 12.sp),
                        ),
                        Text(
                          "O₃",
                          style: TextStyle(color: const Color(0xff9FC8E9), fontSize: 12.sp),
                        ),
                        Text(
                          "CO",
                          style: TextStyle(color: const Color(0xff9FC8E9), fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  SizedBox(
                    height: 138.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // PM10
                        Text(
                          airQualityBean?.now?.pm10 ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        // PM2.5
                        Text(
                          airQualityBean?.now?.pm2p5 ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        // 二氧化氮
                        Text(
                          airQualityBean?.now?.no2 ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        // 二氧化硫
                        Text(
                          airQualityBean?.now?.so2 ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        // 臭氧
                        Text(
                          airQualityBean?.now?.o3 ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        // 一氧化碳
                        Text(
                          airQualityBean?.now?.co ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 风向风力风速
  SliverToBoxAdapter buildWindBox() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.w, top: 20.h),
            child: Text(
              "风向风力风速",
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
          // 动力风车
          Container(
            margin: EdgeInsets.only(left: 0.25.sw, top: 48.h),
            child: Windmills(width: 0.2.sw, height: 0.22.sw),
          ),
          Container(
            margin: EdgeInsets.only(left: 0.35.sw, top: 118.h),
            child: Windmills(width: 0.1.sw, height: 0.11.sw),
          ),
          Container(
            margin: EdgeInsets.only(left: 0.5.sw, top: 60.h),
            height: 138.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 风向
                Text(
                  "风向     ${liveWeatherBean?.now?.windDir}",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                // 风力
                Text(
                  "风力     ${liveWeatherBean?.now?.windScale}级(${getWindScale(int.parse(liveWeatherBean?.now?.windScale ?? "0"))})",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                // 风速
                Text(
                  "风速     ${liveWeatherBean?.now?.windSpeed}km/h",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 生活指数
  SliverList buildLifeIndex() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(lifeIndexBean?.daily?.length ?? 0, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Text(
              "${lifeIndexBean?.daily?[index].name}：${lifeIndexBean?.daily?[index].text ?? lifeIndexBean?.daily?[index].category}",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          );
        }),
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
    SharedPreferences.getInstance().then((prefs) {
      cityName = prefs.getString(Constant.city) ?? cityName;
      // 搜索城市
      searchCity();
    });
  }

  /// 切换城市
  void switchCity(String? name) {
    if (name == null || name.isEmpty) {
      return;
    }
    setState(() {
      cityName = name;
    });
    searchCity();
    SharedPreferences.getInstance().then((value) => value.setString(Constant.city, name));
  }

  /// 搜索城市  模糊搜索，国内范围 返回10条数据
  void searchCity() {
    if (cityName == null) {
      return;
    }
    Api.searchCity(cityName!, callback: (data) {
      setState(() {
        searchCityBean = data;
      });
      var location = searchCityBean?.location?.first;
      // 城市id
      var id = location?.id;
      adm2 = location?.adm2;
      if (id != null) {
        // 实时天气
        liveWeatherNow(id);
        // 未来2小时每5分钟降雨预报
        minutelyWeather("${location!.lon},${location.lat}");
        // 逐小时天气预报
        hourlyWeather(id);
        // 逐日天气预报
        dailyWeather(id);
        // 当天空气质量
        airQuality(id);
        // 生活指数
        lifeIndex(id);
      }
    });
  }

  /// 实时天气
  void liveWeatherNow(String id) {
    Api.liveWeatherNow(id, callback: (data) {
      setState(() {
        liveWeatherBean = data;
      });
    });
  }

  /// 未来2小时每5分钟降雨预报
  void minutelyWeather(String id) {
    Api.minutelyWeather(id, callback: (data) {
      setState(() {
        minutelyWeatherBean = data;
      });
    });
  }

  /// 逐小时天气预报 未来24小时
  void hourlyWeather(String id) {
    Api.hourlyWeather(id, callback: (data) {
      setState(() {
        hourlyWeatherBean = data;
      });
    });
  }

  /// 逐日天气预报 (免费订阅)最多可以获得7天的数据
  void dailyWeather(String id) {
    Api.dailyWeather(id, callback: (data) {
      setState(() {
        dailyWeatherBean = data;
      });
    });
  }

  /// 当天空气质量
  void airQuality(String id) {
    Api.airQualityNow(id, callback: (data) {
      setState(() {
        airQualityBean = data;
      });
    });
  }

  /// 生活指数
  void lifeIndex(String id) {
    Api.lifeIndex(id, callback: (data) {
      setState(() {
        lifeIndexBean = data;
      });
    });
  }
}
