import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
        ],
      ),
    );
  }
}
