import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_good_weather/constant/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 自定义标题栏
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? imgName;

  const TitleBar(this.title, {Key? key, this.imgName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        // 状态栏高度
        top: MediaQueryData.fromWindow(window).padding.top,
      ),
      alignment: Alignment.center,
      color: Colors.transparent,
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
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Positioned(
            right: 20,
            width: 32,
            height: 32,
            child: imgName != null
                ? imgName!.endsWith(".svg")
                    ? SvgPicture.asset(
                        "${Constant.assetsSvg}$imgName",
                      )
                    : Image(
                        image: AssetImage("${Constant.assetsImages}$imgName"),
                      )
                : Container(),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(window.physicalSize.width,
      MediaQueryData.fromWindow(window).padding.top + 40.0);
}
