import 'package:flutter/material.dart';
import 'package:flutter_good_weather/pages/city/manage_city_page.dart';
import 'package:flutter_good_weather/pages/home/home_page.dart';

/// https://www.jianshu.com/p/b9d6ec92926f
class Navi {
  static const homePage = "app://HomePage";
  static const manageCityPage = "app://ManageCityPage";

  Navi();

  Widget getPage(String url, {dynamic params}) {
    switch (url) {
      case homePage:
        return const HomePage();
      case manageCityPage:
        return const ManageCityPage();
    }
    return Container();
  }

  Navi.push(BuildContext context, String url, {dynamic params}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return getPage(url, params: params);
    }));
  }

  pushForResult(BuildContext context, String url, {dynamic params}) async {
    return await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return getPage(url, params: params);
    }));
  }
}
