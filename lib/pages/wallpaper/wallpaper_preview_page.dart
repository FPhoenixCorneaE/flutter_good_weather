import 'package:flutter/material.dart';
import 'package:flutter_good_weather/util/toast_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../constant/constant.dart';

/// 壁纸预览
class WallpaperPreviewPage extends StatefulWidget {
  final List<String?>? imageList;
  final int initialPage;

  const WallpaperPreviewPage(this.imageList, this.initialPage, {super.key});

  @override
  State<WallpaperPreviewPage> createState() => _WallpaperPreviewPageState();
}

class _WallpaperPreviewPageState extends State<WallpaperPreviewPage> {
  late int currentPosition;

  @override
  void initState() {
    super.initState();
    currentPosition = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            child: PageView.builder(
              controller: PageController(initialPage: widget.initialPage),
              onPageChanged: (position) {
                currentPosition = position;
              },
              itemBuilder: (context, index) {
                return FadeInImage.memoryNetwork(
                  image: widget.imageList?[index] ?? "",
                  placeholder: kTransparentImage,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                );
              },
              itemCount: widget.imageList?.length ?? 0,
            ),
          ),
          Positioned(
            left: 20.w,
            top: 60.h,
            child: InkWell(
              // shape圆角半径
              borderRadius: BorderRadius.circular(36.w),
              child: SvgPicture.asset(
                "${Constant.assetsSvg}ic_back_black.svg",
                color: Colors.white,
                width: 36.w,
                height: 36.w,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20.h,
            child: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setInt(Constant.wallpaperType, 1);
                        prefs.setString(Constant.wallpaper, widget.imageList?[currentPosition] ?? "");
                        showBottomToast("设置成功！");
                      });
                    },
                    color: Colors.white.withOpacity(0.2),
                    textColor: Colors.white,
                    shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 1.w)),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    height: 32.h,
                    child: Text(
                      "设为壁纸",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  MaterialButton(
                    onPressed: () {

                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.h))),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    height: 32.h,
                    child: Text(
                      "下载壁纸",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
