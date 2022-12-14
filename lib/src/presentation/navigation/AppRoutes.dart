import 'package:flutter/material.dart';
import 'package:mapata/src/data/util/Constants.dart';
import 'package:mapata/src/presentation/views/HomeView.dart';
import 'package:mapata/src/presentation/views/ProfileView.dart';

import '../../data/model/Post.dart';
import '../views/posts/CreatePostView.dart';
import '../views/posts/PostView.dart';
import 'PostViewArguments.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case kRouteHome:
        return _materialRoute(HomeView());
      case kRouteProfile:
        return _materialRoute(ProfileView());
      case kRouteCreatePost:
        if(arguments is PostViewArguments){
          return _materialRoute(CreatePostView(arguments));
        }
        break;
      case kRouteViewPost:
        if(arguments is PostViewArguments){
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
