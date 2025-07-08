import 'package:cognivolve/screens/games/risk_task/game_screen.dart';
import 'package:cognivolve/widgets/info_screen.dart';
import 'package:flutter/material.dart';

class RiskDescScreen extends StatelessWidget {
  static const routeName = '/risk_desc';
  const RiskDescScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScreen(routeName: RiskGameScreen.routeName, message: '');
  }
}