import 'package:flutter/material.dart';
import 'package:pro_music/src/route/custom_material_page_route.dart';
import 'package:pro_music/src/ui/home/screens/music_details_screen.dart';
import 'package:pro_music/src/ui/home/screens/music_lists_screen.dart';

class Routes {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MusicListsScreen.ROUTE_NAME:
        return _navigate(MusicListsScreen(), settings);
      case MusicDetailsScreen.ROUTE_NAME:
        return _navigate(MusicDetailsScreen(settings.arguments), settings);
    }
    return null;
  }
}

_navigate(Widget child, RouteSettings settings) {
  return CustomMaterialPageRoute(
      settings: settings,
      builder: (context) {
        return child;
      });
}
