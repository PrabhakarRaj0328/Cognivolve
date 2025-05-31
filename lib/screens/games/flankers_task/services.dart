import 'dart:math';
import 'package:cognivolve/screens/games/flankers_task/patterns.dart';
import 'package:flutter/material.dart';

class PatternResult {
  final SizedBox pattern;
  final String direction;

  PatternResult({required this.pattern, required this.direction});
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

  static PatternResult randomPattern(String imgUrl) {
    final List<double> angles = directionGenerator();
    final Random random = Random();
    List<SizedBox> patternList1 = [
      Difficulty1.downArrow(angles[0],angles[1],imgUrl), 
      Difficulty1.upArrow(angles[0],angles[1],imgUrl),
      Difficulty1.leftArrow(angles[0],angles[1],imgUrl),
      Difficulty1.rightArrow(angles[0],angles[1],imgUrl),
      Difficulty1.verPattern(angles[0],angles[1],imgUrl),
      Difficulty1.horPattern(angles[0],angles[1],imgUrl),
    ];
    List<SizedBox> patternList2 = [
      Difficulty3.downArrow(angles[0],angles[1],imgUrl), 
      Difficulty3.upArrow(angles[0],angles[1],imgUrl),
      Difficulty3.leftArrow(angles[0],angles[1],imgUrl),
      Difficulty3.rightArrow(angles[0],angles[1],imgUrl),
      Difficulty3.verPattern(angles[0],angles[1],imgUrl),
      Difficulty3.horPattern(angles[0],angles[1],imgUrl),
    ];
    final int randomDiff = random.nextInt(2);
    final int randomPatt = random.nextInt(patternList2.length);
    final List<SizedBox> patternList = randomDiff==1? patternList2 : patternList1;
    return PatternResult(pattern: patternList[randomPatt], direction: getDirectionFromAngle(angles[0]));
  
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
  static const int totalDuration = 45;
  static const int phaseDuration = 15;
  
  static List<Map<String, String>> getRandomThreePairs(List<Map<String, String>> allPairs) {
    List<Map<String, String>> shuffled = List.from(allPairs);
    shuffled.shuffle();
    return shuffled.take(3).toList();
  }
  
  static int getCurrentPhase(int remainingTime) {
    int elapsedTime = totalDuration - remainingTime;
    return (elapsedTime ~/ phaseDuration).clamp(0, 2);
  }
  
  static Map<String, String> getImagePairForPhase(int phase, List<Map<String, String>> selectedPairs) {
    return selectedPairs[phase];
  }
}

