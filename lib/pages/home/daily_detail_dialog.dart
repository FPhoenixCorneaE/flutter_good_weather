import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/daily_weather_bean.dart';
import 'package:flutter_good_weather/util/date_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant/constant.dart';

/// 逐日预报详情弹窗
class DailyDetailDialog extends StatelessWidget {
  final Daily? daily;

  const DailyDetailDialog(this.daily, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 利用Wrap宽高自适应
    return Center(
      child: Wrap(
        children: [
          Card(
            // 背景色
            color: Colors.white,
            // 阴影颜色
            shadowColor: Colors.deepOrange,
            // 阴影高度
            elevation: 8.h,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.w))),
            // 是否在 child 前绘制 border，默认为 true
            borderOnForeground: true,
            // 外边距
            margin: EdgeInsets.all(50.w),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20.h),
                      child: Text(
                        "天气预报详情",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20.h,
                      right: 20.w,
                      child: GestureDetector(
                        child: SvgPicture.asset(
                          "${Constant.assetsSvg}ic_close.svg",
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 8.h),
                  child: Text(
                    "${daily?.fxDate} ${getDayOfWeek(daily?.fxDate)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 420.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  alignment: Alignment.topCenter,
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      // 横轴2个子widget
                      crossAxisCount: 2,
                      // 宽高比为6
                      childAspectRatio: 6,
                    ),
                    children: [
                      buildDailyItem("最高温", "${daily?.tempMax}℃"),
                      buildDailyItem("最低温", "${daily?.tempMin}℃"),
                      buildDailyItem("紫外线强度", "${daily?.uvIndex}"),
                      buildDailyItem("白天天气状况", "${daily?.textDay}"),
                      buildDailyItem("晚上天气状况", "${daily?.textNight}"),
                      buildDailyItem("白天风向360角度", "${daily?.wind360Day}°"),
                      buildDailyItem("晚上风向360角度", "${daily?.wind360Night}°"),
                      buildDailyItem("白天风向", "${daily?.windDirDay}"),
                      buildDailyItem("晚上风向", "${daily?.windDirNight}"),
                      buildDailyItem("白天风力等级", "${daily?.windScaleDay}级"),
                      buildDailyItem("晚上风力等级", "${daily?.windScaleNight}级"),
                      buildDailyItem("白天风速", "${daily?.windSpeedDay}公里/小时"),
                      buildDailyItem("晚上风速", "${daily?.windSpeedNight}公里/小时"),
                      buildDailyItem("云量", "${daily?.cloud}%"),
                      buildDailyItem("相对湿度", "${daily?.humidity}%"),
                      buildDailyItem("大气压强", "${daily?.pressure}hPa"),
                      buildDailyItem("降水量", "${daily?.precip}mm"),
                      buildDailyItem("能见度", "${daily?.vis}km"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDailyItem(String name, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.black, fontSize: 14.sp),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 30.sp),
          ),
        ],
      ),
    );
  }
}
