import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/my_city_bean.dart';
import 'package:flutter_good_weather/db/my_city_dao.dart';
import 'package:flutter_good_weather/widget/title_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant/constant.dart';

/// 管理城市
class ManageCityPage extends StatefulWidget {
  const ManageCityPage({Key? key}) : super(key: key);

  @override
  State<ManageCityPage> createState() => _ManageCityPageState();
}

class _ManageCityPageState extends State<ManageCityPage> {
  List<MyCityBean>? myCityList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: TitleBar(
        "管理城市",
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        leftImgName: "ic_back_black.svg",
        onLeftImgTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        color: Colors.grey.withAlpha(88),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Wrap(
                      children: [
                        Card(
                          // 背景色
                          color: Colors.white,
                          // 阴影颜色
                          shadowColor: Colors.grey,
                          // 阴影高度
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          // 是否在 child 前绘制 border，默认为 true
                          borderOnForeground: true,
                          // 外边距
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(16),
                                    child: Text(
                                      myCityList?[index].cityName ?? "",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(
                                    context, myCityList?[index].cityName);
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      color: Colors.transparent,
                    );
                  },
                  itemCount: myCityList?.length ?? 0,
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "${Constant.assetsSvg}ic_add.svg",
                        width: 24,
                        height: 24,
                        color: Colors.black,
                      ),
                      const Text(
                        "添加城市",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  CityPickers.showCitiesSelector(context: context)
                      .then((result) {
                    if (result?.cityName != null &&
                        result?.cityName?.isNotEmpty == true) {
                      MyCityDao.getInstance().insert([
                        MyCityBean(cityName: result?.cityName)
                      ]).then((value) {
                        getAllCityData();
                      });
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getAllCityData();
  }

  void getAllCityData() {
    MyCityDao.getInstance().queryAll().then((value) {
      setState(() {
        myCityList = value;
      });
    });
  }
}
