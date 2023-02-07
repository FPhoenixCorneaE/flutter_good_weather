import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_good_weather/constant/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 自定义标题栏
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final String title;
  final Color? titleColor;
  final String? leftImgName;
  final GestureTapCallback? onLeftImgTap;
  final String? rightImgName;
  final GestureTapCallback? onRightImgTap;

  const TitleBar(
    this.title, {
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.titleColor = Colors.white,
    this.leftImgName,
    this.onLeftImgTap,
    this.rightImgName,
    this.onRightImgTap,
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
              style: TextStyle(fontSize: 24, color: titleColor),
            ),
          ),
          Positioned(
            left: 20,
            width: 32,
            height: 32,
            child: Material(
              // 背景色
              color: Colors.transparent,
              child: InkWell(
                // shape圆角半径
                borderRadius: BorderRadius.circular(16),
                child: leftImgName != null
                    ? leftImgName!.endsWith(".svg")
                        ? SvgPicture.asset(
                            "${Constant.assetsSvg}$leftImgName",
                          )
                        : Image(
                            image: AssetImage(
                                "${Constant.assetsImages}$leftImgName"),
                          )
                    : Container(),
                onTap: () {
                  onLeftImgTap?.call();
                },
              ),
            ),
          ),
          Positioned(
            right: 20,
            width: 32,
            height: 32,
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
                          )
                        : Image(
                            image: AssetImage(
                                "${Constant.assetsImages}$rightImgName"),
                          )
                    : Container(),
                onTap: () {
                  onRightImgTap?.call();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(window.physicalSize.width,
      MediaQueryData.fromWindow(window).padding.top + 40.0);
}
