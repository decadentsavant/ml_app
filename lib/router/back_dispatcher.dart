import 'package:flutter/material.dart';
import 'package:ml_app/router/router_delegate.dart';


class MLBackButtonDispatcher extends RootBackButtonDispatcher {
  MLBackButtonDispatcher(this._routerDelegate) : super();

  final MLRouterDelegate _routerDelegate;

  @override
  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}
