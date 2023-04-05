import 'package:flutter/material.dart';
import 'package:huo_la_la/components/location/location.dart';
import 'package:huo_la_la/utils/theme.dart';
import '../page_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _headerHeight = 70;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        width: double.infinity,
        child: IconButton(icon: const Icon(Icons.close), onPressed: _closeDrawer),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: _headerHeight,
            color: HomePageTheme.headerBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Location(onLocationTap: _openDrawer, textColor: HomePageTheme.headerTextColor)],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeEndDrawer();
  }
}
