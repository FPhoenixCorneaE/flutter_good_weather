import 'package:flutter/material.dart';
import 'package:flutter_good_weather/widget/title_bar.dart';

import '../../constant/constant.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: const TitleBar(
        "城市天气",
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
                  // 天气状况
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

  /// 逐日天气预报列表
  SliverFixedExtentList buildDailyWeather() {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 20, top: 12, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                // 时间
                Text(
                  "1月17日今天",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                // 气候图标
                Image(
                    width: 32,
                    height: 32,
                    image: AssetImage(
                        "${Constant.assetsImages}ic_weather_100.png")),
                // 温度
                Text(
                  "14℃/9℃",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          );
        }, childCount: 7),
        itemExtent: 48);
  }

  /// 逐小时天气预报列表
  SliverToBoxAdapter buildHourlyWeather() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 12, right: 20),
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          itemBuilder: (context, index) {
            // 子条目的布局样式
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                // 时间
                Text(
                  "上午10:00",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                // 气候图标
                Image(
                    width: 32,
                    height: 32,
                    image: AssetImage(
                        "${Constant.assetsImages}ic_weather_100.png")),
                // 温度
                Text(
                  "12℃",
                  style: TextStyle(fontSize: 20, color: Colors.white),
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

  /// 天气状况
  SliverToBoxAdapter buildWeatherCondition() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          // 星期几
          const Positioned(
              left: 20,
              top: 8,
              child: Text(
                "星期几",
                style: TextStyle(fontSize: 18, color: Colors.white),
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
                    child: const Text(
                      "12",
                      style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // 摄氏度符号
                    Text(
                      "℃",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    // 天气状况和空气质量
                    Text(
                      "多云",
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
                child: const Text(
                  "14℃/9℃",
                  style: TextStyle(fontSize: 14, color: Colors.white),
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
                    const Text(
                      "最近更新时间：下午15:45",
                      style: TextStyle(color: Colors.white, fontSize: 12),
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

  Future<void> _onRefresh() async {
    return Future.delayed(const Duration(seconds: 2), () {});
  }
}
