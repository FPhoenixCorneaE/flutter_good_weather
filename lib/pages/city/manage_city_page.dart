import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/my_city_bean.dart';
import 'package:flutter_good_weather/db/my_city_dao.dart';
import 'package:flutter_good_weather/widget/title_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: const TitleBar(
        "管理城市",
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        leftImgName: "ic_back_black.svg",
      ),
      body: Container(
        color: const Color(0xfff5f5f5),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16.h),
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
                          elevation: 4.h,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.w))),
                          // 是否在 child 前绘制 border，默认为 true
                          borderOnForeground: true,
                          // 外边距
                          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(16.w),
                                    child: Text(
                                      myCityList?[index].cityName ?? "",
                                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context, myCityList?[index].cityName);
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 0, color: Colors.transparent);
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
                  height: 60.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "${Constant.assetsSvg}ic_add.svg",
                        width: 24.w,
                        height: 24.w,
                        color: Colors.black,
                      ),
                      Text(
                        "添加城市",
                        style: TextStyle(color: Colors.black, fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  CityPickers.showCitiesSelector(context: context).then((result) {
                    if (result?.cityName != null && result?.cityName?.isNotEmpty == true) {
                      MyCityDao.getInstance().insert([MyCityBean(cityName: result?.cityName)]).then((value) {
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
