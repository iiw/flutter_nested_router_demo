import 'package:demo_navigator_2/domain/book.dart';
import 'package:demo_navigator_2/domain/books.dart';
import 'package:demo_navigator_2/router/page/fade_animation_page.dart';
import 'package:demo_navigator_2/router/path/base_path.dart';
import 'package:demo_navigator_2/router/state/app_router_state.dart';
import 'package:demo_navigator_2/screens/book_details.dart';
import 'package:demo_navigator_2/screens/book_list.dart';
import 'package:demo_navigator_2/screens/settings.dart';
import 'package:flutter/material.dart';

class InnerRouterDelegate extends RouterDelegate<BaseRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BaseRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  AppRouterState get appState => _appState;
  AppRouterState _appState;
  set appState(AppRouterState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
              books: books,
              onTapped: _handleBookTapped,
            ),
            key: ValueKey('BooksListPage'),
          ),
          if (appState.selectedBook != null)
            MaterialPage(
              key: ValueKey(appState.selectedBook),
              child: BookDetailsScreen(book: appState.selectedBook!),
            ),
        ] else
          FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
      ],
      onPopPage: (route, result) {
        appState.selectedBook = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BaseRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleBookTapped(Book book) {
    appState.selectedBook = book;
    notifyListeners();
  }
}
