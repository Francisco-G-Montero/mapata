import 'package:flutter/material.dart';
import 'package:mapata/src/data/util/Constants.dart';
import 'package:mapata/src/presentation/views/HomeView.dart';
import 'package:mapata/src/presentation/views/ProfileView.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case kRouteHome:
        return _materialRoute(HomeView());
      case kRouteProfile:
        return _materialRoute(ProfileView());
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}