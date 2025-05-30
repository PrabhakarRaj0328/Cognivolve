import 'dart:math';

import 'package:cognivolve/screens/games/flankers_task/patterns.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Difficulty3.leftArrow(0, pi/2, 'fish.png'));
  }
}