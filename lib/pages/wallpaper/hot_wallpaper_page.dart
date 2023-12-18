import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_good_weather/bean/hot_wallpaper_bean.dart';
import 'package:flutter_good_weather/http/api/api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../navi.dart';
import '../../widget/title_bar.dart';

class HotWallpaperPage extends StatefulWidget {
  const HotWallpaperPage({super.key});

  @override
  State<HotWallpaperPage> createState() => _HotWallpaperPageState();
}

class _HotWallpaperPageState extends State<HotWallpaperPage> {
  HotWallpaperBean? hotWallpaperBean;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    Api.hotWallpaper(callback: (data) {
      setState(() {
        hotWallpaperBean = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置AppBar状态栏透明
      extendBodyBehindAppBar: true,
      appBar: const TitleBar(
        "热门壁纸",
        backgroundColor: Colors.transparent,
        titleColor: Colors.black,
        leftImgName: "ic_back_black.svg",
        leftImgColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          itemBuilder: (context, index) {
            return InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: FadeInImage.memoryNetwork(
                  image: hotWallpaperBean?.res?.vertical?[index].thumb ?? "",
                  placeholder: kTransparentImage,
                  fit: BoxFit.cover,
                  height: random.nextInt(100).h + 480.h,
                ),
              ),
              onTap: () {
                Navi.push(
                  context,
                  Navi.wallpaperPreviewPage,
                  params: {
                    "imageList": hotWallpaperBean?.res?.vertical?.map((e) => e.img).toList(),
                    "initialPage": index,
                  },
                );
              },
            );
          },
          itemCount: hotWallpaperBean?.res?.vertical?.length ?? 0,
        ),
      ),
    );
  }
}
