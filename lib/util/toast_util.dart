import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  void showCenterToast(msg) {
    _showToast(msg, gravity: ToastGravity.CENTER);
  }

  void showBottomToast(msg) {
    _showToast(msg, gravity: ToastGravity.BOTTOM);
  }

  void showTopToast(msg) {
    _showToast(msg, gravity: ToastGravity.TOP);
  }

  /// android 11 以上版本不会起作用
  void showWarnToast(msg) {
    _showToast(msg,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.CENTER);
  }

  void cancelToast() {
    Fluttertoast.cancel();
  }

  _showToast(msg,
      {toastLength = Toast.LENGTH_SHORT, gravity, textColor, backgroundColor}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: gravity,
        textColor: textColor,
        backgroundColor: backgroundColor);
  }
}
