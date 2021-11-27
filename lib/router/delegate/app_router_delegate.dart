import 'package:demo_navigator_2/router/path/base_path.dart';
import 'package:demo_navigator_2/router/path/paths.dart';
import 'package:demo_navigator_2/router/state/app_router_state.dart';
import 'package:demo_navigator_2/screens/root.dart';
import 'package:flutter/material.dart';

class AppRouterDelegate extends RouterDelegate<BaseRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BaseRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterState appState = AppRouterState();

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  BaseRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return BooksSettingsPath();
    } else {
      if (appState.selectedBook == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(appState.getSelectedBookById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: RootScreen(appState: appState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appState.selectedBook != null) {
          appState.selectedBook = null;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BaseRoutePath path) async {
    if (path is BooksListPath) {
      appState.selectedIndex = 0;
      appState.selectedBook = null;
    } else if (path is BooksSettingsPath) {
      appState.selectedIndex = 1;
    } else if (path is BooksDetailsPath) {
      appState.setSelectedBookById(path.id);
    }
  }
}
