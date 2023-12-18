import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/disaster_warning_bean.dart';
import 'package:flutter_good_weather/pages/airquality/more_air_quality_page.dart';
import 'package:flutter_good_weather/pages/city/manage_city_page.dart';
import 'package:flutter_good_weather/pages/disasterwarning/disaster_warning_detail_page.dart';
import 'package:flutter_good_weather/pages/home/home_page.dart';
import 'package:flutter_good_weather/pages/livingindex/more_living_index_page.dart';
import 'package:flutter_good_weather/pages/wallpaper/set_wallpaper_page.dart';

/// https://www.jianshu.com/p/b9d6ec92926f
class Navi {
  static const homePage = "app://HomePage";
  static const manageCityPage = "app://ManageCityPage";
  static const moreAirQualityPage = "app://MoreAirQualityPage";
  static const disasterWarningDetailPage = "app://DisasterWarningDetailPage";
  static const moreLivingIndexPage = "app://MoreLivingIndexPage";
  static const setWallpaperPage = "app://SetWallpaperPage";

  Navi();

  Widget getPage(String url, {dynamic params}) {
    switch (url) {
      case homePage:
        return const HomePage();
      case manageCityPage:
        return const ManageCityPage();
      case moreAirQualityPage:
        Map<String, String?> paramsMap = params as Map<String, String?>;
        return MoreAirQualityPage(
          paramsMap["adm2"] ?? "",
          paramsMap["location"] ?? "",
        );
      case disasterWarningDetailPage:
        return DisasterWarningDetailPage(params as DisasterWarningBean?);
      case moreLivingIndexPage:
        Map<String, String?> paramsMap = params as Map<String, String?>;
        return MoreLivingIndexPage(
          paramsMap["location"],
          paramsMap["locationId"],
        );
      case setWallpaperPage:
        return const SetWallpaperPage();
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
