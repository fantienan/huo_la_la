import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import '../../utils/util.dart';

class BMFBaseMapState<T extends StatefulWidget> extends State<T> {
  late BMFMapController mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("..."));
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) async {
    mapController = controller;

    // Map? map1 = await mapController.getNativeMapCopyright();
    // print('获取原生地图版权信息：$map1');
    // Map? map2 = await mapController.getNativeMapApprovalNumber();
    // print('获取原生地图审图号：$map2');
    // Map? map3 = await mapController.getNativeMapQualification();
    // print('获取原生地图测绘资质：$map3');

    /// 地图加载回调
    mapController.setMapDidLoadCallback(callback: () {
      printDebug('mapDidLoad-地图加载完成');
    });
  }

  /// 设置地图参数
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917215, 116.380341),
      zoomLevel: 12,
    );
    return mapOptions;
  }

  /// 创建地图
  SizedBox generateMap() {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(onBMFMapCreated: onBMFMapCreated, mapOptions: initMapOptions()),
    );
  }

  /// 创建控制栏
  Widget generateControlBar() {
    throw UnimplementedError();
  }
}
