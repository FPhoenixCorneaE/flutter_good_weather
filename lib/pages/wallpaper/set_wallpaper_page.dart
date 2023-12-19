import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';
import '../../navi.dart';
import '../../widget/title_bar.dart';

/// 设置壁纸
class SetWallpaperPage extends StatefulWidget {
  const SetWallpaperPage({super.key});

  @override
  State<SetWallpaperPage> createState() => _SetWallpaperPageState();
}

class _SetWallpaperPageState extends State<SetWallpaperPage> {
  final wallpaperCategory = ["热门壁纸", "每日一图", "手动上传", "默认壁纸"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: const TitleBar(
        "设置壁纸",
        backgroundColor: Colors.transparent,
        titleColor: Colors.black,
        leftImgName: "ic_back_black.svg",
        leftImgColor: Colors.black,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        wallpaperCategory[index],
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          "${Constant.assetsSvg}ic_back_black.svg",
                          width: 16.w,
                          height: 16.w,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  switch (index) {
                    case 0:
                      Navi.push(context, Navi.hotWallpaperPage);
                      break;
                    case 3:
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setInt(Constant.wallpaperType, 0);
                        prefs.setString(Constant.wallpaper, "${Constant.assetsImages}pic_bg_home.jpg");
                      });
                      break;
                  }
                },
              ),
              Container(
                width: double.infinity,
                height: 0.5.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                color: Colors.grey.withOpacity(0.4),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Container();
        },
        itemCount: 4,
      ),
    );
  }
}
