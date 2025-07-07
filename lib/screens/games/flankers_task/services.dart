import 'dart:math';
import 'package:cognivolve/screens/games/flankers_task/patterns.dart';
import 'package:flutter/material.dart';

class RandomPattern {
  final SizedBox pattern;
  final String direction;
  final String patternName;

  RandomPattern(this.patternName, {required this.pattern, required this.direction});
}
class FlankersTaskServices {

  static List<double> directionGenerator() {
    List<double> angles = [0, pi/2, pi, 3*pi/2];

    final Random random = Random();
    double targetDirection = angles[random.nextInt(angles.length)];
    double otherDirection = angles[random.nextInt(angles.length)];
    List<double> birdDirections = [targetDirection, otherDirection];
    return birdDirections;
  }

  static RandomPattern randomPattern(String imgUrl) {
    final List<double> angles = directionGenerator();
    final Random random = Random();
    List<PatternResult> patternList1 = [
      Difficulty1.downArrow(angles[0],angles[1],imgUrl), 
      Difficulty1.upArrow(angles[0],angles[1],imgUrl),
      Difficulty1.leftArrow(angles[0],angles[1],imgUrl),
      Difficulty1.rightArrow(angles[0],angles[1],imgUrl),
      Difficulty1.verPattern(angles[0],angles[1],imgUrl),
      Difficulty1.horPattern(angles[0],angles[1],imgUrl),
    ];
    List<PatternResult> patternList2 = [
      Difficulty3.downArrow(angles[0],angles[1],imgUrl), 
      Difficulty3.upArrow(angles[0],angles[1],imgUrl),
      Difficulty3.leftArrow(angles[0],angles[1],imgUrl),
      Difficulty3.rightArrow(angles[0],angles[1],imgUrl),
      Difficulty3.verPattern(angles[0],angles[1],imgUrl),
      Difficulty3.horPattern(angles[0],angles[1],imgUrl),
    ];
    final int randomDiff = random.nextInt(2);
    final int randomPatt = random.nextInt(patternList2.length);
    final List<PatternResult> patternList = randomDiff==1? patternList2 : patternList1;
    return RandomPattern(pattern: patternList[randomPatt].widget, direction: getDirectionFromAngle(angles[0]), patternList[randomPatt].patternName);
  
  }

  static String getDirectionFromAngle(double direction) {
    switch (direction) {
      case 0:
        return 'up';
      case const (pi/2):
        return 'right';
      case const(pi):
        return 'down';
      case const(3*pi/2):
        return 'left';
      default:
      return 'bleh';
    }
  }
}
class GamePhaseManager {

  static List<Map<String, String>> getRandomThreePairs(List<Map<String, String>> allPairs) {
    List<Map<String, String>> shuffled = List.from(allPairs);
    shuffled.shuffle();
    return shuffled.take(3).toList();
  }

  static Map<String,String> getRandomPair(List<Map<String, String>> allPairs) {
    final Random random = Random();
    return allPairs[random.nextInt(allPairs.length)];
  }
  
}

