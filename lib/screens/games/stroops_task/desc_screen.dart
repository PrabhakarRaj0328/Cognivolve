import 'package:cognivolve/screens/games/stroops_task/game_screen.dart';
import 'package:cognivolve/widgets/info_screen.dart';
import 'package:flutter/material.dart';

class StroopDesc extends StatefulWidget {
  static const String routeName = '/stroop_desc';
  const StroopDesc({super.key});

  @override
  State<StroopDesc> createState() => _StroopDescState();
}

class _StroopDescState extends State<StroopDesc> {
  @override
  Widget build(BuildContext context) {
    return InfoScreen(routeName: StroopsTask.routeName,);
  }
}