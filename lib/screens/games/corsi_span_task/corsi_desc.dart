import 'package:cognivolve/screens/games/corsi_span_task/game_screen.dart';
import 'package:cognivolve/widgets/info_screen.dart';
import 'package:flutter/material.dart';

class CorsiDesc extends StatefulWidget {
  static const String routeName = '/corsi_task_desc';
  const CorsiDesc({super.key});

  @override
  State<CorsiDesc> createState() => _CorsiDescState();
}

class _CorsiDescState extends State<CorsiDesc> {
  @override
  Widget build(BuildContext context) {
    return InfoScreen(
      routeName: CorsiSpanTask.routeName,
      message:
          "If the blocks light up in yellow, repeat the sequence in the same order. If they light up in red, repeat the sequence in reverse order.\nCaution: After 3 wrong attempts, you will lose!",
    );
  }
}
