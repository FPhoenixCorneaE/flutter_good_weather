import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_good_weather/util/permission_util.dart';
import 'package:permission_handler/permission_handler.dart';

/// 动态权限申请
class PermissionRequestPage extends StatefulWidget {
  const PermissionRequestPage(this.permissions, {super.key});

  final List<Permission> permissions;

  @override
  State<PermissionRequestPage> createState() => _PermissionRequestPageState();
}

class _PermissionRequestPageState extends State<PermissionRequestPage>
    with WidgetsBindingObserver {
  late final String _msg;
  var _isGranted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _msg = "为了更好地应用体验,请确定权限，否则可能无法正常工作。\n是否申请权限？";
    checkPermission(widget.permissions);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 监听 app 从后台切回前台
    if (state == AppLifecycleState.resumed && !_isGranted) {
      checkPermission(widget.permissions);
    }
  }

  /// 校验权限
  void checkPermission(List<Permission> permissions) {
    showAlert(permissions);
  }

  void showAlert(List<Permission> permissions) {
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
                    _popDialogAndPage(context);
                  }),
              CupertinoDialogAction(
                  child: const Text("确定"),
                  onPressed: () {
                    PermissionUtil.checkPermission(
                        permissionList: permissions,
                        onFailed: () {
                          _isGranted = false;
                          showAlert(permissions);
                        },
                        onSuccess: () async {
                          _popPage();
                        });
                    _popDialog(context);
                  })
            ],
          );
        });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  /// 退出应用程序
  void _quitApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  /// 关闭整个权限申请页面
  void _popDialogAndPage(BuildContext dialogContext) {
    _popDialog(dialogContext);
    _popPage();
  }

  /// 关闭弹窗
  void _popDialog(BuildContext dialogContext) {
    Navigator.of(dialogContext).pop();
  }

  /// 关闭透明页面
  void _popPage() {
    Navigator.of(context).pop();
  }
}
