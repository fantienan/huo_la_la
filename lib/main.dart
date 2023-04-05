import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:get/get.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart' show BMFMapSDK, BMF_COORD_TYPE;
import 'package:huo_la_la/utils/util.dart';
import 'components/location/utils.dart';
import 'page_router.dart';

const apiKey = "znxzFNHBZQRuv3GGMYgLuzG77S85Vpil";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocationFlutterPlugin locationPlugin = LocationFlutterPlugin();

  /// 动态申请定位权限
  requestLocationPermission();

  /// 设置用户是否同意SDK隐私协议
  locationPlugin.setAgreePrivacy(true);
  BMFMapSDK.setAgreePrivacy(true);

  /// 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    // 设置ios端apk，android端可以质检在清单文件中配置
    locationPlugin.authAK(apiKey);
    BMFMapSDK.setApiKeyAndCoordType(apiKey, BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    // 初始化获取Android系统版本号
    await BMFAndroidVersion.initAndroidVersion();
    // Android 不支持接口设置apk， 在主工程Manifest文件中设置
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }
  Map? mapVersion = await BMFMapVersion.nativeMapVersion;
  printDebug("获取原生地图版本号：$mapVersion");

  /// ios端鉴权结果
  locationPlugin.getApiKeyCallback(callback: (String result) {
    printDebug("ios端鉴权结果：$result");
  });
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'huo_la_la',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        brightness: Brightness.light,
        primaryColor: Colors.orange,
      ),
      home: Router(
        routerDelegate: pageRouter,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
