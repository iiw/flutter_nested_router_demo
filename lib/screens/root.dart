import 'package:demo_navigator_2/router/delegate/inner_router_delegate.dart';
import 'package:demo_navigator_2/router/state/app_router_state.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  final AppRouterState appState;

  const RootScreen({
    required this.appState,
  });

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late InnerRouterDelegate _routerDelegate;
  late ChildBackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(covariant RootScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Scaffold(
      appBar: AppBar(),
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: appState.selectedIndex,
        onTap: (newIndex) {
          appState.selectedIndex = newIndex;
        },
      ),
    );
  }
}
