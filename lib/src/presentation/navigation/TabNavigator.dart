import 'package:flutter/material.dart';
import 'package:mapata/src/presentation/navigation/TabItem.dart';
import 'package:mapata/src/presentation/views/HomeView.dart';
import 'package:mapata/src/presentation/views/ProfileView.dart';

class TabNavigatorRoutes {
  static const String home = "home";
  static const String profile = "profile";
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.home: (context) => HomeView(),
      TabNavigatorRoutes.profile: (context) => ProfileView(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.home,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) =>
                  routeBuilders[routeSettings.name]!(context));
        });
  }
}