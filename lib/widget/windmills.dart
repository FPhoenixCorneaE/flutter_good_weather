import 'dart:math';

import 'package:flutter/material.dart';

/// 风车widget
class Windmills extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const Windmills(
      {super.key, required this.width, required this.height, this.color = Colors.white});

  @override
  State<StatefulWidget> createState() {
    return _WindmillsState();
  }
}

class _Windmills extends StatelessWidget {
  final double width;
  final double height;
  final double progress;
  final Color color;

  const _Windmills(
      {this.width = 100,
      this.height = 100,
      this.progress = 0,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WindmillsPainter(width, height, progress, color),
      size: Size(width, height),
    );
  }
}

class _WindmillsPainter extends CustomPainter {
  final double width;
  final double height;
  final Color color;

  /// 旋转进度
  final double progress;

  /// 半径
  late double r;

  /// 1角度 =  radians弧度
  double radians = pi / 180;

  _WindmillsPainter(this.width, this.height, this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) async {
    r = width / 2;
    var fanPath = Path();

    var paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..color = color;

    /// 扇叶的宽度
    double fanWidth = width/2;

    /// 圆柱
    var pillarPath = Path();
    pillarPath.moveTo(r + 1, fanWidth + 3);
    pillarPath.lineTo(r + 4, height - 2);
    pillarPath.quadraticBezierTo(r, height, r - 4, height - 2);
    pillarPath.lineTo(r - 1, fanWidth + 3);
    pillarPath.lineTo(r + 1, fanWidth + 3);
    pillarPath.close();
    canvas.drawPath(pillarPath, paint);

    /// 中间圆点
    canvas.drawCircle(Offset(r, fanWidth), 2, paint);

    /// 初始的扇叶。
    /// 初始时旋转的原点在(0,0)，平移原点到圆心
    canvas.translate(r, fanWidth);

    /// 旋转
    canvas.rotate(radians * progress);

    /// 留2个宽度放圆点
    fanPath.moveTo(2, 0);
    fanPath.quadraticBezierTo(fanWidth / 4, -4, fanWidth / 2, -2);
    fanPath.lineTo(fanWidth, 0);
    fanPath.lineTo(fanWidth / 2, 2);
    fanPath.quadraticBezierTo(fanWidth / 4, 4, 2, 0);
    fanPath.close();
    canvas.drawPath(fanPath, paint);

    /// 第二个扇叶
    canvas.save();
    canvas.rotate(radians * 120);
    canvas.drawPath(fanPath, paint);
    canvas.restore();

    /// 第三个扇叶
    canvas.save();
    canvas.rotate(radians * 240);
    canvas.drawPath(fanPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _WindmillsState extends State<Windmills> with SingleTickerProviderStateMixin {
  double progress = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..addListener(() {
            setState(() {
              progress = _animationController.value * 360;
            });
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _Windmills(
      width: widget.width,
      height: widget.height,
      progress: progress,
      color: widget.color,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


