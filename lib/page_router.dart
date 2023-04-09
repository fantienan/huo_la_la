import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'pages/map.dart';
import 'pages/home/home.dart';
import 'pages/message.dart';
import 'pages/mine.dart';
import 'pages/order.dart';
import 'pages/not_found.dart';

PageRouter pageRouter = PageRouter();

class PageRouter extends RouterDelegate<List<RouteSettings>> with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  static const homePagePath = '/home';
  static const messagePagePath = '/message';
  static const minePagePath = '/mine';
  static const orderPagePath = '/order';
  static const notFoundPagePath = '/404';
  static const mapPagePath = '/map';
  static const homePageIndex = 0;
  static const orderPageIndex = 1;
  static const messagePageIndex = 2;
  static const minePageIndex = 3;
  static Map<String, WidgetBuilder> routes = {
    homePagePath: (BuildContext context) => const HomePage(),
    orderPagePath: (BuildContext context) => const OrderPage(),
    messagePagePath: (BuildContext context) => const MessagePage(),
    minePagePath: (BuildContext context) => const MinePage(),
    notFoundPagePath: (BuildContext context) => const NotFound(),
    mapPagePath: (BuildContext context) => const MapPage(),
  };

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final List<RouteSettings> _routeSettings = [];
  final Map<String, int> _pagePathMapIndex = {
    homePagePath: homePageIndex,
    orderPagePath: orderPageIndex,
    messagePagePath: messagePageIndex,
    minePagePath: minePageIndex,
  };
  late Completer<Object?> _boolResultCompleter;

  PageRouter() {
    _routeSettings.add(const RouteSettings(name: homePagePath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(key: navigatorKey, pages: _getPages(context), onPopPage: _onPopPage),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  @override
  List<RouteSettings> get currentConfiguration => List.unmodifiable(_routeSettings);

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {
    _routeSettings.clear();
    _routeSettings.addAll(configuration);
    return SynchronousFuture<void>(null);
  }

  /// 设置应用启动时的初始路由路径
  @override
  Future<void> setInitialRoutePath(List<RouteSettings> configuration) {
    _routeSettings.clear();
    _routeSettings.addAll(configuration);
    // SynchronousFuture 表示没有异步操作需要等待
    return SynchronousFuture<void>(null);
  }

  @override
  Future<bool> popRoute({Object? params}) {
    if (params != null) _boolResultCompleter.complete(params);
    if (_routeSettings.length > 1) {
      _routeSettings.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return _confirmExit();
  }

  List<Page> _getPages(BuildContext context) {
    return _routeSettings.map((routeSettings) => _buildPage(context, routeSettings)).toList();
  }

  Page _buildPage(BuildContext context, RouteSettings routeSettings) {
    var widgetBuilder = routes[routeSettings.name];
    return MaterialPage(
      key: _getPageStorageKey(routeSettings),
      child: widgetBuilder != null ? widgetBuilder(context) : routes[notFoundPagePath]!(context),
      arguments: routeSettings.arguments,
    );
  }

  String? getCurrentRouter() {
    return _routeSettings.isNotEmpty ? _routeSettings.last.name : null;
  }

  int? _getBottomNavigationBarCurrentIndex(BuildContext context) {
    return _pagePathMapIndex[getCurrentRouter()];
  }

  Widget? _bottomNavigationBar(BuildContext context) {
    var currentIndex = _getBottomNavigationBarCurrentIndex(context);
    return currentIndex == null
        ? null
        : BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
              BottomNavigationBarItem(icon: Icon(Icons.article), label: '订单'),
              BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
            ],
            onTap: (value) {
              switch (value) {
                case homePageIndex:
                  pushRoute(const RouteSettings(name: homePagePath, arguments: ''));
                  break;
                case orderPageIndex:
                  pushRoute(const RouteSettings(name: orderPagePath, arguments: ''));
                  break;
                case messagePageIndex:
                  pushRoute(const RouteSettings(name: messagePagePath, arguments: ''));
                  break;
                case minePageIndex:
                  pushRoute(const RouteSettings(name: minePagePath, arguments: ''));
                  break;
                default:
                  pushRoute(const RouteSettings(name: notFoundPagePath, arguments: ''));
                  break;
              }
            },
          );
  }

  /// 页面弹出时
  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;
    _routeSettings.remove(route.settings);
    notifyListeners();
    return true;
  }

  PageStorageKey _getPageStorageKey(RouteSettings routeSettings) {
    return PageStorageKey(routeSettings.name);
  }

  Future<Object?> pushRoute(RouteSettings routeSettings) {
    _boolResultCompleter = Completer<Object?>();
    var cacheRouteSetting = _routeSettings.firstWhereOrNull((element) => element.name == routeSettings.name);
    if (cacheRouteSetting == null) {
      _routeSettings.add(routeSettings);
    } else {
      _routeSettings.remove(cacheRouteSetting);
      _routeSettings.add(cacheRouteSetting);
    }
    notifyListeners();
    return _boolResultCompleter.future;
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(content: const Text('确认推出吗？'), actions: [
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("取消")),
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("确定")),
          ]);
        });
    return result ?? true;
  }
}
