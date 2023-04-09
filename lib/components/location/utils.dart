import 'package:permission_handler/permission_handler.dart';

import '../../utils/util.dart';

/// 动态申请定位权限
Future<bool> requestLocationPermission() async {
  // 申请权限
  bool hasLocationPermission = await _requestLocationPermission();
  if (hasLocationPermission) {
    printDebug("动态申请定位权限结果：$hasLocationPermission");
  } else {}
  return hasLocationPermission;
}

/// 申请定位权限，授予定位权限返回true，否则返回false
Future<bool> _requestLocationPermission() async {
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    return true;
  }
  status = await Permission.location.request();
  return status == PermissionStatus.granted;
}
