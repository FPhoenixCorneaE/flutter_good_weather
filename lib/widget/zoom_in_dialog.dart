import 'package:flutter/material.dart';
import 'zoom_in_offset.dart';

/// 放大弹窗
class ZoomInDialog extends StatefulWidget {
  final double right; // 距离右边位置 弹窗的x轴定位
  final double top; // 距离上面位置 弹窗的y轴定位
  final bool otherClose; // 点击背景关闭页面
  final Widget child; // 传入弹窗的样式
  final Function? fun; // 把关闭的函数返回给父组件 参考vue的$emit
  final Offset? offset; // 弹窗动画的起点

  const ZoomInDialog({
    super.key,
    required this.child,
    this.right = 0,
    this.top = 0,
    this.otherClose = false,
    this.fun,
    this.offset,
  });

  @override
  _ZoomInDialogState createState() => _ZoomInDialogState();
}

class _ZoomInDialogState extends State<ZoomInDialog> {
  AnimationController? animateController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
              ),
              onTap: () async {
                if (widget.otherClose) {
                } else {
                  closeModel();
                }
              },
            ),
          ),
          Positioned(
            right: widget.right,
            top: widget.top,

            /// 这个是弹窗动画
            child: ZoomInOffset(
              duration: const Duration(milliseconds: 180),
              offset: widget.offset,
              controller: (controller) {
                animateController = controller;
                widget.fun?.call(closeModel);
              },
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  /// 关闭页面动画
  Future closeModel() async {
    await animateController?.reverse();
    Navigator.pop(context);
  }
}
