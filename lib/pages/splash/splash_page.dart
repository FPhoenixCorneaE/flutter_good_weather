import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_good_weather/bean/province_bean.dart';
import 'package:flutter_good_weather/db/province_dao.dart';
import 'package:flutter_good_weather/navi.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constant/constant.dart';
import '../../util/permission_util.dart';

/// 打开App启动页
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  // 申请权限
  final _permissions = [
    Permission.location,
    Permission.storage,
    Permission.microphone,
    Permission.phone
  ];

  late final String _msg;
  var _isGranted = false;

  @override
  void initState() {
    super.initState();
    // 用来观察应用切换状态
    WidgetsBinding.instance.addObserver(this);
    _msg = "为了更好地应用体验，请确定权限，否则可能无法正常工作。\n是否申请权限？";
    // 延时弹窗，否则会出现异常：dependOnInheritedWidgetOfExactType<_InheritedCupertinoTheme>() or dependOnInheritedElement() was called before _SplashPageState.initState() completed.
    Future.delayed(const Duration(milliseconds: 100), () {
      _checkPermission(_permissions);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 监听 app 从后台切回前台
    if (state == AppLifecycleState.resumed && !_isGranted) {
      _checkPermission(_permissions);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 加载本地json文件
    rootBundle.loadString("${Constant.assetsJson}province.json").then((value) {
      List<dynamic> provinceList = json.decode(value);
      List<ProvinceBean> list = [];
      for (var data in provinceList) {
        list.add(ProvinceBean.fromJson(data));
      }
      ProvinceDao.getInstance().insert(list);
    });
    if (_isGranted) {
      Future.delayed(const Duration(seconds: 2), () {
        Navi.push(context, Navi.homePage);
      });
    }
    return Image(
      image: const AssetImage("${Constant.assetsImages}pic_bg_splash.png"),
      // 图片渐显效果
      frameBuilder: (context, child, frame, wasSynchronousLoaded) {
        if (wasSynchronousLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: frame != null
                ? child
                : Container(
                    color: Colors.white,
                  ),
          );
        }
        ;
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 校验权限
  Future<void> _checkPermission(List<Permission> permissions) async {
    if (!await checkSelfPermission(permissions)) {
      _showAlert(permissions);
    } else {
      setGranted(true);
    }
  }

  void _showAlert(List<Permission> permissions) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("温馨提示"),
            content: Text(_msg),
            actions: [
              CupertinoDialogAction(
                  child: const Text("取消"),
                  onPressed: () {
                    _quitApp();
                  }),
              CupertinoDialogAction(
                  child: const Text("确定"),
                  onPressed: () {
                    _popDialog(context);
                    checkPermission(
                        permissionList: permissions,
                        onFailed: () {
                          // 权限至少有一个没有申请成功
                          setGranted(false);
                          _popDialog(context);
                          _showAlert(permissions);
                        },
                        onSuccess: () async {
                          // 权限申请成功
                          setGranted(true);
                          _popDialog(context);
                        });
                  })
            ],
          );
        });
  }

  void setGranted(bool granted) {
    setState(() {
      _isGranted = granted;
    });
  }

  /// 退出应用程序
  void _quitApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  /// 关闭弹窗
  void _popDialog(BuildContext dialogContext) {
    Navigator.of(dialogContext).pop();
  }
}
