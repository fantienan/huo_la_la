import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import '../components/map/map_base_state.dart';

class MapPage extends StatefulWidget {
  final BMFMapOptions? customMapOptions;
  const MapPage({super.key, this.customMapOptions});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends BMFBaseMapState<MapPage> {
  BMFMapType mapType = BMFMapType.Standard;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: BMFAppBar(
        //   title: '地图类型示例',
        //   onBack: () {
        //     Navigator.pop(context);
        //   },
        // ),
        body: Stack(children: <Widget>[generateMap()]),
      ),
    );
  }
}
