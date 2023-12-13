import 'dart:async';

import 'package:flutter/material.dart';

/// 跑马灯 Builder 类型
typedef MarqueeWidgetBuilder = Widget Function(BuildContext context, int index, BoxConstraints constraints);

/// 跑马灯
class MarqueeWidget extends StatefulWidget {
  String? title;

  int itemCount;

  /// item builder
  MarqueeWidgetBuilder itemBuilder;

  /// 边界(前后新增) builder
  MarqueeWidgetBuilder edgeBuilder;

  /// item 间距 builder
  MarqueeWidgetBuilder separatorBuilder;

  /// 控制器
  ScrollController? controller;

  /// 定时器运行间隔
  Duration? duration;

  /// 定时器运行间隔移动偏移量
  double? durationOffset;

  MarqueeWidget({
    Key? key,
    this.title,
    this.controller,
    this.duration = const Duration(milliseconds: 350),
    this.durationOffset = 30,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.edgeBuilder,
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  ScrollController? _scrollController;

  final _globalKey = GlobalKey();

  Timer? _timer;

  @override
  void initState() {
    _scrollController = widget.controller ?? ScrollController();
    _initTimer();
    super.initState();
  }

  @override
  void dispose() {
    _cancelTimer();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return Container();
    }

    final totalCount = widget.itemCount + 2;

    return LayoutBuilder(builder: (context, constraints) {
      return ListView.separated(
        key: _globalKey,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(0),
        itemCount: totalCount,
        itemBuilder: (context, index) {
          final isEdge = (index == 0 || index == totalCount - 1);
          if (isEdge) {
            return widget.edgeBuilder(context, index, constraints);
          }
          return widget.itemBuilder(context, index - 1, constraints);
        },
        separatorBuilder: (context, index) {
          if (index == 0 || index == totalCount - 2) {
            return Container();
          }
          return widget.separatorBuilder(context, index, constraints);
        },
      );
    });
  }

  /// 取消定时器
  _cancelTimer({bool isContinue = false}) {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      if (isContinue) {
        _initTimer();
      }
    }
  }

  /// 初始化定时任务
  _initTimer() {
    if (_timer == null) {
      final duration = widget.duration ?? const Duration(milliseconds: 350);
      _timer = Timer.periodic(
        duration,
        (t) {
          if (_scrollController == null) {
            return;
          }
          final val = _scrollController!.offset + (widget.durationOffset ?? 30);
          _scrollController!.animateTo(val, duration: duration, curve: Curves.linear);
          if (_scrollController!.position.outOfRange) {
            // print("atEdge:到边界了");
            _scrollController!.jumpTo(0);
          }
        },
      );
    }
  }
}
