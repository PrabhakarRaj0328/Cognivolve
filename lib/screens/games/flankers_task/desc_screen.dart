import 'package:cognivolve/screens/games/flankers_task/game_screen.dart';
import 'package:cognivolve/widgets/info_screen.dart';
import 'package:flutter/material.dart';

class FlankersTaskDesc extends StatefulWidget {
  static const String routeName = '/flankers_task_desc';
  const FlankersTaskDesc({super.key});

  @override
  State<FlankersTaskDesc> createState() => _FlankersTaskDescState();
}

class _FlankersTaskDescState extends State<FlankersTaskDesc> {
  @override
  Widget build(BuildContext context) {
    return InfoScreen(routeName: FlankersTask.routeName,message: "Swipe in the direction of the center bird",);
  }
}
