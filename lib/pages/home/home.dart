import 'package:flutter/material.dart';
import 'cargo_address.dart';
import 'package:huo_la_la/components/location/location.dart';
import 'package:huo_la_la/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _headerHeight = 142;
  static const double _bottomNavigationBarHeight = 58;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HomePageTheme.bodyBackgroundColor,
      endDrawer: Drawer(
        width: double.infinity,
        child: IconButton(icon: const Icon(Icons.close), onPressed: _closeDrawer),
      ),
      body: Column(
        children: [_header(), _createBody(context)],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      height: _headerHeight,
      color: HomePageTheme.headerBackgroundColor,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Location(onLocationTap: _openDrawer, textColor: HomePageTheme.headerTextColor)],
          ),
        )
      ]),
    );
  }

  Widget _createBody(BuildContext context) {
    return Stack(children: [
      Container(
        height: 20,
        color: HomePageTheme.headerBackgroundColor,
      ),
      ConstrainedBox(
          constraints: BoxConstraints(maxHeight: _getBodyMaxHeight(context)),
          child: Scrollbar(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.elliptical(16, 14), topRight: Radius.elliptical(16, 14)),
                    color: HomePageTheme.bodyBackgroundColor,
                  ),
                  child: const Padding(padding: EdgeInsets.only(top: 10), child: Text('小面')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: List.generate(5, (index) => const Text('7米6')),
                  ),
                ),
                const CargoAddress(),
              ],
            )),
          ))
    ]);
  }

  Size _getScreenSize(BuildContext context) => MediaQuery.of(context).size;

  // 获取body最大高度
  double _getBodyMaxHeight(BuildContext context) => _getScreenSize(context).height - _headerHeight - _bottomNavigationBarHeight;

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeEndDrawer();
  }
}
