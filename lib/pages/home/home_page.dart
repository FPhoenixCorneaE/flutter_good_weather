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
          children: const <Widget>[
            Positioned.fill(
                child: Image(
              image: AssetImage("${Constant.assetsImages}pic_bg_home.jpg"),
              fit: BoxFit.cover,
            )),
            CustomScrollView(
              // 根据正在查看的内容确定滚动视图的范围
              // shrinkWrap: true,
              // 内容
              slivers: <Widget>[
                SliverToBoxAdapter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    return Future.delayed(const Duration(seconds: 2), () {});
  }
}
