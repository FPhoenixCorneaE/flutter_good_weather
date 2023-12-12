import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_good_weather/constant/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 自定义标题栏
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final double? titleBarHeight;
  final String title;
  final Color? titleColor;
  final double? titleSize;
  final String? leftImgName;
  final Color? leftImgColor;
  final GestureTapCallback? onLeftImgTap;
  final String? rightImgName;
  final Color? rightImgColor;
  final String? rightImg2Name;
  final Color? rightImg2Color;
  final GestureTapCallback? onRightImgTap;
  final GestureTapCallback? onRightImg2Tap;

  const TitleBar(
    this.title, {
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.titleBarHeight,
    this.titleColor = Colors.white,
    this.titleSize,
    this.leftImgName,
    this.leftImgColor,
    this.onLeftImgTap,
    this.rightImgName,
    this.rightImgColor,
    this.rightImg2Name,
    this.rightImg2Color,
    this.onRightImgTap,
    this.onRightImg2Tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        // 状态栏高度
        top: MediaQueryData.fromWindow(window).padding.top,
      ),
      alignment: Alignment.center,
      color: backgroundColor,
      child: Stack(
        // 使子widget与stack大小一致
        fit: StackFit.expand,
        // 未被Positioned包括或没有设置位置的Widget对齐方式
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: titleSize ?? 18.sp, color: titleColor,fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            left: 20.w,
            width: 32.w,
            height: 32.w,
            child: Material(
              // 背景色
              color: Colors.transparent,
              child: InkWell(
                // shape圆角半径
                borderRadius: BorderRadius.circular(16.w),
                child: leftImgName != null
                    ? leftImgName!.endsWith(".svg")
                        ? SvgPicture.asset(
                            "${Constant.assetsSvg}$leftImgName",
                            color: leftImgColor,
                          )
                        : Image(
                            image: AssetImage("${Constant.assetsImages}$leftImgName"),
                            color: leftImgColor,
                          )
                    : Container(),
                onTap: () {
                  onLeftImgTap?.call();
                },
              ),
            ),
          ),
          Positioned(
            right: 68.w,
            width: 32.w,
            height: 32.w,
            child: Material(
              // 背景色
              color: Colors.transparent,
              child: InkWell(
                // shape圆角半径
                borderRadius: BorderRadius.circular(16),
                child: rightImgName != null
                    ? rightImgName!.endsWith(".svg")
                        ? SvgPicture.asset(
                            "${Constant.assetsSvg}$rightImgName",
                            color: rightImgColor,
                          )
                        : Image(
                            image: AssetImage("${Constant.assetsImages}$rightImgName"),
                            color: rightImgColor,
                          )
                    : Container(),
                onTap: () {
                  onRightImgTap?.call();
                },
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            width: 32.w,
            height: 32.w,
            child: Material(
              // 背景色
              color: Colors.transparent,
              child: InkWell(
                // shape圆角半径
                borderRadius: BorderRadius.circular(16.w),
                child: rightImg2Name != null
                    ? rightImg2Name!.endsWith(".svg")
                        ? SvgPicture.asset(
                            "${Constant.assetsSvg}$rightImg2Name",
                            color: rightImg2Color,
                          )
                        : Image(
                            image: AssetImage("${Constant.assetsImages}$rightImg2Name"),
                            color: rightImg2Color,
                          )
                    : Container(),
                onTap: () {
                  onRightImg2Tap?.call();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(window.physicalSize.width, MediaQueryData.fromWindow(window).padding.top + (titleBarHeight ?? 36.h));
}
