import 'package:flutter/material.dart';
import 'package:flutter_good_weather/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

/// 壁纸图片
class WallpaperImage extends StatefulWidget {
  const WallpaperImage({super.key});

  @override
  State<WallpaperImage> createState() => _WallpaperImageState();
}

class _WallpaperImageState extends State<WallpaperImage> with TickerProviderStateMixin {
  int? wallpaperType;
  String wallpaper = "";

  @override
  void initState() {
    super.initState();
    getWallpaperConfig();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 绑定 TickerMode 可走该生命周期
    // 参考：Flutter 小而美系列｜TickerProviderStateMixin 对生命周期的影响(https://juejin.cn/post/6915008425806004231)
    TickerMode.of(context);
    getWallpaperConfig();
  }

  @override
  Widget build(BuildContext context) {
    return wallpaperType == null
        ? Container()
        : wallpaperType == 1 || wallpaperType == 2
            ? FadeInImage.memoryNetwork(
                image: wallpaper,
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
              )
            : Image(
                image: AssetImage(wallpaper),
                fit: BoxFit.cover,
              );
  }

  void getWallpaperConfig() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        wallpaperType = prefs.getInt(Constant.wallpaperType) ?? 0;
        wallpaper = prefs.getString(Constant.wallpaper) ?? "${Constant.assetsImages}pic_bg_home.jpg";
      });
    });
  }
}
