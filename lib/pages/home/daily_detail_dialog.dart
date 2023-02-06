import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/daily_weather_bean.dart';
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
            elevation: 8,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            // 是否在 child 前绘制 border，默认为 true
            borderOnForeground: true,
            // 外边距
            margin: const EdgeInsets.all(50),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "天气预报详情",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        child: SvgPicture.asset(
                          "${Constant.assetsSvg}ic_close.svg",
                          width: 24,
                          height: 24,
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
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    "${daily?.fxDate}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 320,
                  margin: const EdgeInsets.only(left: 60, top: 8, right: 60),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // 横轴2个子widget
                      crossAxisCount: 2,
                      // 宽高比为6
                      childAspectRatio: 6,
                    ),
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "最高温",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.tempMax}℃"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "最低温",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.tempMin}℃"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "紫外线强度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.uvIndex}"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "白天天气状况",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.textDay}"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "晚上天气状况",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.textNight}"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "白天风向360角度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.wind360Day}°"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "晚上风向360角度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.wind360Night}°"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "白天风向",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.windDirDay}"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "晚上风向",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.windDirNight}"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "白天风力",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.windScaleDay}级"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "晚上风力",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.windScaleNight}级"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "白天风速",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.windSpeedDay}公里/小时"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "晚上风速",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.windSpeedNight}公里/小时"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "云量",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.cloud}%"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "相对湿度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.humidity}%"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "大气压强",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.pressure}hPa"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "降水量",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.precip}mm"),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "能见度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${daily?.vis}km"),
                          ],
                        ),
                      ),
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
}
