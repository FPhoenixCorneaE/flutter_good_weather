import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/hourly_weather_bean.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant/constant.dart';
import '../../util/date_util.dart';

/// 逐小时预报详情弹窗
class HourlyDetailDialog extends StatelessWidget {
  final Hourly? hourly;

  const HourlyDetailDialog(this.hourly, {Key? key}) : super(key: key);

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
                        "逐小时预报详情",
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
                    divideTime(updateTime(hourly?.fxTime)),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 280.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      // 横轴2个子widget
                      crossAxisCount: 2,
                      // 宽高比为6
                      childAspectRatio: 6,
                    ),
                    children: [
                      buildHourlyItem("温度", "${hourly?.temp}℃"),
                      buildHourlyItem("天气状况", "${hourly?.text}"),
                      buildHourlyItem("风向360角度", "${hourly?.wind360}°"),
                      buildHourlyItem("风向", "${hourly?.windDir}"),
                      buildHourlyItem("风力等级", "${hourly?.windScale}级"),
                      buildHourlyItem("风速", "${hourly?.windSpeed}公里/小时"),
                      buildHourlyItem("相对湿度", "${hourly?.humidity}%"),
                      buildHourlyItem("当前小时累计降水量", "${hourly?.precip}mm"),
                      buildHourlyItem("降水概率", "${hourly?.pop}%"),
                      buildHourlyItem("大气压强", "${hourly?.pressure}hPa"),
                      buildHourlyItem("云量", "${hourly?.cloud}%"),
                      buildHourlyItem("露点温度", "${hourly?.dew}℃"),
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

  Container buildHourlyItem(String name, String value) {
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
