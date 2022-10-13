import 'package:flutter/material.dart';
import 'package:mapata/src/data/util/Constants.dart';
import 'package:mapata/src/presentation/views/HomeView.dart';
import 'package:mapata/src/presentation/views/ProfileView.dart';

import '../views/posts/CreatePostView.dart';
import '../views/posts/PostView.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case kRouteHome:
        return _materialRoute(HomeView());
      case kRouteProfile:
        return _materialRoute(ProfileView());
      case kRouteCreatePost:
        return _materialRoute(CreatePostView());
      case kRouteViewPost:
        if(arguments is String){
          //si viene un argumento con el id del post, navego al post y ahi dentro cargo la data
          return _materialRoute(PostView(arguments));
        }
        break;
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
