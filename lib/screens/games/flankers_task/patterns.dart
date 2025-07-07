import 'package:flutter/material.dart';

double containerSize = 65.0;

List<Map<String, String>> images = [
  {'bgUrl': 'flankers_task_images/space.png', 'imgUrl': 'flankers_task_images/spaceship.png'},
  {'bgUrl': 'flankers_task_images/road.png', 'imgUrl': 'flankers_task_images/car.png'},
  {'bgUrl': 'flankers_task_images/underwater.png', 'imgUrl': 'flankers_task_images/fish.png'},
  {'bgUrl': 'flankers_task_images/sky.png', 'imgUrl': 'flankers_task_images/plane.png'},
];
class PatternResult {
  final SizedBox widget;
  final String patternName;
  
  PatternResult({
    required this.widget,
    required this.patternName,
  });
}

Transform bird(double angle, String imgUrl) => Transform.rotate(
  angle: angle,
  child: Container(
    margin: EdgeInsets.all(0.075*containerSize),
    height: containerSize*0.85,
    width: containerSize*0.85,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/$imgUrl'),
        fit: BoxFit.contain,
      ),
    ),
  ),
);
class TrialData {
  final int trialNumber;
  final String targetDirection;
  final String userSwipe;
  final bool isCorrect;
  final int reactionTime;
  final String imagePair;
  final String pattern;

  TrialData({
    required this.trialNumber,
    required this.targetDirection,
    required this.userSwipe,
    required this.isCorrect,
    required this.reactionTime,
    required this.imagePair,
    required this.pattern, 
  });

  Map<String, dynamic> toJson() => {
    'trialNumber': trialNumber,
    'targetDirection': targetDirection,
    'userSwipe': userSwipe,
    'isCorrect': isCorrect,
    'reactionTime': reactionTime,
    'imagePair': imagePair,
    'pattern': pattern,
  };
}

class Difficulty1 {
  static PatternResult horPattern(double targetAngle, otherAngle, String imgUrl) {
    final widget = SizedBox(
      width: containerSize * 5,
      height: containerSize,
      child: Row(
        children: [
          bird(otherAngle, imgUrl),
          bird(otherAngle, imgUrl),
          bird(targetAngle, imgUrl),
          bird(otherAngle, imgUrl),
          bird(otherAngle, imgUrl),
        ],
      ), 
  );
   return PatternResult(widget: widget, patternName: 'smallHorizontal');
  }

  static PatternResult verPattern(double targetAngle, otherAngle, String imgUrl) {
    final widget =  SizedBox(
      width: containerSize,
      height: containerSize * 5,
      
      child: Column(
        children: [
          bird(otherAngle, imgUrl),
          bird(otherAngle, imgUrl),
          bird(targetAngle, imgUrl),
          bird(otherAngle, imgUrl),
          bird(otherAngle, imgUrl),
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'smallVerical');
  }

  static PatternResult upArrow(double targetAngle, otherAngle, String imgUrl) {
    final widget = SizedBox(
      width: containerSize * 5,
      height: containerSize * 3,
      child: Column(
        children: [
          Row(children: [Spacer(),bird(targetAngle, imgUrl),Spacer()]),
          Row(children: [Spacer(),bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),Spacer()]),
          Row(children: [bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),],)
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'smallUp');
  }

  static PatternResult downArrow(double targetAngle, otherAngle, String imgUrl) {
    final widget = SizedBox(
      width: containerSize * 5,
      height: containerSize * 3,
      child: Column(
        children: [          
          Row(children: [bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),],),
          Row(children: [Spacer(),bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),Spacer()]),
          Row(children: [Spacer(),bird(targetAngle, imgUrl),Spacer()]),
        ],
      ),
      );
      return PatternResult(widget: widget, patternName: 'smallDown');
  }

  static PatternResult rightArrow(double targetAngle, otherAngle, String imgUrl) {
    final widget = SizedBox(
      width: containerSize * 3,
      height: containerSize * 5,
      child: Row(
        children: [          
          Column(children: [bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),],),
        Column(children: [Spacer(),bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),Spacer()]),
        Column(children: [Spacer(),bird(targetAngle, imgUrl),Spacer()]),
        ],
      ),
      );
      return PatternResult(widget: widget, patternName: 'smallRight');
  }

  static PatternResult leftArrow(double targetAngle, otherAngle, String imgUrl) {
    final widget = SizedBox(
      width: containerSize * 3,
      height: containerSize * 5,
      child: Row(
        children: [  
        Column(children: [Spacer(),bird(targetAngle, imgUrl),Spacer()]), 
        Column(children: [Spacer(),bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),Spacer()]),       
        Column(children: [bird(otherAngle, imgUrl),Spacer(),bird(otherAngle, imgUrl),],),
        ],
      ),
      );
      return PatternResult(widget: widget, patternName: 'smallLeft');
  }
}

class Difficulty3 {
  static PatternResult horPattern(double targetAngle, otherAngle, String imgUrl) {
   final widget = SizedBox(
      width: containerSize * 5,
      height: containerSize * 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Difficulty1.horPattern(otherAngle, otherAngle, imgUrl).widget ,
          Difficulty1.horPattern(targetAngle, otherAngle, imgUrl).widget,
          Difficulty1.horPattern(otherAngle, otherAngle, imgUrl).widget,
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'bigHorizontal');
  }

  static PatternResult verPattern(double targetAngle, otherAngle, String imgUrl) {
    final widget = SizedBox(
      width: containerSize * 3,
      height: containerSize * 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Difficulty1.verPattern(otherAngle, otherAngle, imgUrl).widget,
          Difficulty1.verPattern(targetAngle, otherAngle, imgUrl).widget,
          Difficulty1.verPattern(otherAngle, otherAngle, imgUrl).widget,
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'bigVertical');
  }

  static PatternResult upArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    final widget = SizedBox(
      width: containerSize * 5,
      height: containerSize * 3,
      child: Column(
        children: [
          Row(children: [Spacer(),bird(otherAngle, imgUrl),Spacer()]),
          Row(children: [Spacer(),bird(otherAngle, imgUrl),bird(targetAngle, imgUrl),bird(otherAngle, imgUrl),Spacer()]),
          Row(children: [bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),],)
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'bigUp');
  }

  static PatternResult downArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    final widget = SizedBox(
      width: containerSize * 5,
      height: containerSize * 3,
      child: Column(
        children: [
          Row(children: [bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),],),
          Row(children: [Spacer(),bird(otherAngle, imgUrl),bird(targetAngle, imgUrl),bird(otherAngle, imgUrl),Spacer()]),
          Row(children: [Spacer(),bird(otherAngle, imgUrl),Spacer()]),
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'bigDown');
  }

  static PatternResult rightArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    final widget = SizedBox(
      width: containerSize * 3,
      height: containerSize * 5,
      child: Row(
        children: [  
        Column(children: [bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),],),
        Column(children: [Spacer(),bird(otherAngle, imgUrl),bird(targetAngle, imgUrl),bird(otherAngle, imgUrl),Spacer()]), 
        Column(children: [Spacer(),bird(otherAngle, imgUrl),Spacer()]),       
        
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'bigRight');
  }

  static PatternResult leftArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    final widget = SizedBox(
      width: containerSize * 3,
      height: containerSize * 5,
      child: Row(
        children: [  
          Column(children: [Spacer(),bird(otherAngle, imgUrl),Spacer()]),   
          Column(children: [Spacer(),bird(otherAngle, imgUrl),bird(targetAngle, imgUrl),bird(otherAngle, imgUrl),Spacer()]),     
        Column(children: [bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),bird(otherAngle, imgUrl),],),
        ],
      ),
    );
    return PatternResult(widget: widget, patternName: 'bigLeft');
  }
}
