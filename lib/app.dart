import 'package:demo_navigator_2/router/delegate/app_router_delegate.dart';
import 'package:demo_navigator_2/router/parser/base_route_information_parser.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  BaseRouteInformationParser _routeInformationParser =
      BaseRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
