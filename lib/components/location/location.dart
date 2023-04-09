import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:huo_la_la/utils/util.dart';

class Location extends StatefulWidget {
  final GestureTapCallback? onLocationTap;
  final Color? textColor;
  const Location({super.key, this.onLocationTap, this.textColor});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  BaiduLocation _locationResult = BaiduLocation();
  late BMFMapController _mapController;
  final LocationFlutterPlugin _locationPlugin = LocationFlutterPlugin();
  bool _suc = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      _locationPlugin.singleLocationCallback(callback: (BaiduLocation result) {
        //result为定位结果
        printDebug("ios 定位结果：$result");
        setState(() => _locationResult = result);
      });
    } else if (Platform.isAndroid) {
      _locationPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
        printDebug("android 定位结果：$result");

        setState(() {
          _locationResult = result;
          _locationPlugin.stopLocation();
        });
      });
    }

    ///设置定位参数
    _locationAction();
    _startLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: screenSize.width / 2),
      child: GestureDetector(
        onTap: widget.onLocationTap,
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(text: _locationResult.city ?? ''),
            const WidgetSpan(child: Icon(Icons.expand_more, size: 16, color: Colors.white)),
          ]),
        ),
      ),
    );
  }

  void _locationAction() async {
    /// 设置android端和ios端定位参数
    /// android 端设置定位参数
    /// ios 端设置定位参数
    Map iosMap = initIOSOptions().getMap();
    Map androidMap = initAndroidOptions().getMap();

    _suc = await _locationPlugin.prepareLoc(androidMap, iosMap);
    printDebug('设置定位参数：$iosMap');
  }

  ///定位完成添加mark
  void locationFinish() {
    /// 创建BMFMarker
    BMFMarker marker = BMFMarker.icon(
        position: BMFCoordinate(_locationResult.latitude ?? 0.0, _locationResult.longitude ?? 0.0),
        title: 'flutterMaker',
        identifier: 'flutter_marker',
        icon: 'resoures/icon_mark.png');
    printDebug(_locationResult.latitude.toString() + _locationResult.longitude.toString());

    /// 添加Marker
    _mapController.addMarker(marker);

    ///设置中心点
    _mapController.setCenterCoordinate(BMFCoordinate(_locationResult.latitude ?? 0.0, _locationResult.longitude ?? 0.0), false);
  }

  /// 设置地图参数
  BaiduLocationAndroidOption initAndroidOptions() {
    BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
        coorType: 'bd09ll',
        locationMode: BMFLocationMode.hightAccuracy,
        isNeedAddress: true,
        isNeedAltitude: true,
        isNeedLocationPoiList: true,
        isNeedNewVersionRgc: true,
        isNeedLocationDescribe: true,
        openGps: true,
        locationPurpose: BMFLocationPurpose.sport,
        coordType: BMFLocationCoordType.bd09ll);
    return options;
  }

  BaiduLocationIOSOption initIOSOptions() {
    BaiduLocationIOSOption options = BaiduLocationIOSOption(
        coordType: BMFLocationCoordType.bd09ll,
        BMKLocationCoordinateType: 'BMKLocationCoordinateTypeBMK09LL',
        desiredAccuracy: BMFDesiredAccuracy.best);
    return options;
  }

  /// 启动定位
  Future<void> _startLocation() async {
    if (Platform.isIOS) {
      _suc = await _locationPlugin.singleLocation({'isReGeocode': true, 'isNetworkState': true});
      printDebug('开始单次定位：$_suc');
    } else if (Platform.isAndroid) {
      _suc = await _locationPlugin.startLocation();
    }
  }
}
