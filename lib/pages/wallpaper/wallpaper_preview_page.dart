import 'package:flutter/material.dart';
import 'package:flutter_good_weather/http/http_client.dart';
import 'package:flutter_good_weather/util/toast_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../constant/constant.dart';

/// 壁纸预览
class WallpaperPreviewPage extends StatefulWidget {
  final List<String?>? imageList;
  final int initialPage;
  final int wallpaperType;
  final bool isAssets;

  const WallpaperPreviewPage(
    this.imageList,
    this.wallpaperType, {
    super.key,
    this.initialPage = 0,
    this.isAssets = false,
  });

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
                return !widget.isAssets
                    ? FadeInImage.memoryNetwork(
                        image: widget.imageList?[index] ?? "",
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      )
                    : Image(
                        image: AssetImage(widget.imageList?[index] ?? ""),
                        fit: BoxFit.cover,
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
                        prefs.setInt(Constant.wallpaperType, widget.wallpaperType);
                        var imgUrl = widget.imageList?[currentPosition] ?? "";
                        if (widget.wallpaperType == 1) {
                          imgUrl = imgUrl.substring(0, imgUrl.indexOf("?"));
                        }
                        prefs.setString(Constant.wallpaper, imgUrl);
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
                    onPressed: () async {
                      var applicationCacheDir = await getTemporaryDirectory();
                      if (widget.wallpaperType == 1 || widget.wallpaperType == 2) {
                        int start;
                        int end;
                        String name;
                        if (widget.wallpaperType == 1) {
                          // 热门壁纸的url：
                          start = widget.imageList?[currentPosition]?.indexOf("/", 8) ?? 0;
                          end = widget.imageList?[currentPosition]?.indexOf("?", 8) ?? 0;
                          name = widget.imageList?[currentPosition]?.substring(start, end) ?? "";
                        } else {
                          // 必应每日一图的url：https://cn.bing.com/th?id=OHR.WinterSolstice2023_ZH-CN4450201916_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp
                          start = widget.imageList?[currentPosition]?.indexOf(".", 20) ?? 0;
                          end = widget.imageList?[currentPosition]?.indexOf("&") ?? 0;
                          name = widget.imageList?[currentPosition]?.substring(start + 1, end) ?? "";
                          name = name.replaceAll(".jpg", "");
                        }
                        var savePath = "${applicationCacheDir.path}$name";
                        HttpClient.getInstance()
                            .download(widget.imageList?[currentPosition] ?? "", savePath,
                                name: name, onReceiveProgress: (count, total) {})
                            .then((result) {
                          if ((result?["isSuccess"] as bool) == true) {
                            showBottomToast("图片保存成功");
                          }
                        });
                      }
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
