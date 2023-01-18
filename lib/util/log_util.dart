import 'package:flutter/cupertino.dart';

/// 日志打印
class LogUtil {
  static var _isDebug = true;
  static int _limitLength = 800;

  static void init({@required bool? isDebug, int? limitLength}) {
    _isDebug = isDebug ??= _isDebug;
    _limitLength = limitLength ??= _limitLength;
  }

  /// 仅Debug模式可见
  static void d(dynamic obj) {
    if (_isDebug) {
      _log(obj.toString());
    }
  }

  static void v(dynamic obj) {
    _log(obj.toString());
  }

  static void _log(String msg) {
    if (msg.length < _limitLength) {
      print(msg);
    } else {
      segmentationLog(msg);
    }
  }

  static void segmentationLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % _limitLength == 0 && index != 0) {
        print(outStr);
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < _limitLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print(remainderStr);
          break;
        }
      }
    }
  }
}
