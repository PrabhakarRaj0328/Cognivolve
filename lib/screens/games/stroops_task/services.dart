
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
class StroopTrialData {
  final int trialNumber;
  final String meaningWord;
  final String meaningColor;
  final String textWord;
  final String textColor;
  final bool correctAnswer;
  final bool userResponse;
  final bool isCorrect;
  final int reactionTime;
  final DateTime timestamp;

  StroopTrialData({
    required this.trialNumber,
    required this.meaningWord,
    required this.meaningColor,
    required this.textWord,
    required this.textColor,
    required this.correctAnswer,
    required this.userResponse,
    required this.isCorrect,
    required this.reactionTime,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'trialNumber': trialNumber,
    'meaningWord': meaningWord,
    'meaningColor': meaningColor,
    'textWord': textWord,
    'textColor': textColor,
    'correctAnswer': correctAnswer,
    'userResponse': userResponse,
    'isCorrect': isCorrect,
    'reactionTime': reactionTime,
    'timestamp': timestamp.toIso8601String(),
  };
}

