import 'package:cognivolve/screens/error_screen.dart';
import 'package:cognivolve/screens/games/flankers_task/desc_screen.dart';
import 'package:cognivolve/screens/games/flankers_task/game_screen.dart';
import 'package:cognivolve/screens/games/stroops_task/desc_screen.dart';
import 'package:cognivolve/screens/games/stroops_task/game_screen.dart';
import 'package:cognivolve/screens/landing_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingPage.routeName:
      return MaterialPageRoute(builder: (_) => const LandingPage());
    case FlankersTaskDesc.routeName:
      return MaterialPageRoute(builder: (_) => const FlankersTaskDesc());
    case FlankersTask.routeName:
      return MaterialPageRoute(builder: (_) => FlankersTask());
    case StroopsTask.routeName:
      return MaterialPageRoute(builder: (_) => const StroopsTask());
    case StroopDesc.routeName:
      return MaterialPageRoute(builder: (_) => const StroopDesc());    
    default:
      return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
