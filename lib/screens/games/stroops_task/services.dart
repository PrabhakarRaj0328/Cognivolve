
import 'dart:math';

import 'package:flutter/material.dart';

List<String> colors = ['red', 'black', 'yellow', 'blue'];
List<String> randomColors(){
  final Random random = Random();
  String meaning = colors[random.nextInt(colors.length)];
  String text = colors[random.nextInt(colors.length)];
  String meaningColor = colors[random.nextInt(colors.length)];
  String textColor = colors[random.nextInt(colors.length)];

  return [meaningColor,meaning,textColor,text];
}
Map<String,Color> colorMap = {
  'black':Colors.black,
  'yellow':Colors.yellow,
  'blue':Colors.blue,
  'red':Colors.red,
};

