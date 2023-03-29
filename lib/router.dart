import 'package:flutter/material.dart';

class Router extends RouterDelegate<List<RouteSettings>> with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  @override
  GlobalKey<NavigatorState>? get navigatorKey => throw UnimplementedError();

  final List<Page> _pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
      key: navigatorKey,
      pages: _pages,
      onPopPage: _onPopPage,
    ));
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    throw UnimplementedError();
  }

  /// 页面弹出时
  bool _onPopPage(Route route, dynamic result) {
    _pages.removeLast();
    return true;
  }
}
