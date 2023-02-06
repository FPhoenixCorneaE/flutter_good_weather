import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/hourly_weather_bean.dart';
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
                        "逐小时预报详情",
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
                    divideTime(updateTime(hourly?.fxTime)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
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
                              "温度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.temp}℃"),
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
                              "天气状况",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.text}"),
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
                              "风向360角度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.wind360}°"),
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
                              "风向",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.windDir}"),
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
                              "风力",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.windScale}级"),
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
                              "风速",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.windSpeed}公里/小时"),
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
                            Text("${hourly?.cloud}%"),
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
                            Text("${hourly?.humidity}%"),
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
                            Text("${hourly?.pressure}hPa"),
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
                              "降水概率",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.pop}%"),
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
                              "露点温度",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text("${hourly?.dew}℃"),
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
