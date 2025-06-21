import 'package:cognivolve/screens/error_screen.dart';
import 'package:cognivolve/screens/games/corsi_span_task/corsi_desc.dart';
import 'package:cognivolve/screens/games/corsi_span_task/game_screen.dart';
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
    case CorsiDesc.routeName:
      return MaterialPageRoute(builder: (_) => const CorsiDesc());
    case CorsiSpanTask.routeName:
      return MaterialPageRoute(builder: (_) => const CorsiSpanTask());
    default:
      return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
