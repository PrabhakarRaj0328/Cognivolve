import 'package:flutter/material.dart';

double containerSize = 65.0;

List<Map<String, String>> images = [
  {'bgUrl': 'flankers_task_images/space.png', 'imgUrl': 'flankers_task_images/spaceship.png'},
  {'bgUrl': 'flankers_task_images/road.png', 'imgUrl': 'flankers_task_images/car.png'},
  {'bgUrl': 'flankers_task_images/underwater.png', 'imgUrl': 'flankers_task_images/fish.png'},
  {'bgUrl': 'flankers_task_images/sky.png', 'imgUrl': 'flankers_task_images/plane.png'},
];

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

class Difficulty1 {
  static SizedBox horPattern(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
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
  }

  static SizedBox verPattern(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
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
  }

  static SizedBox upArrow(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
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
  }

  static SizedBox downArrow(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
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
  }

  static SizedBox rightArrow(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
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
  }

  static SizedBox leftArrow(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
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
  }
}

class Difficulty3 {
  static SizedBox horPattern(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
      width: containerSize * 5,
      height: containerSize * 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Difficulty1.horPattern(otherAngle, otherAngle, imgUrl),
          Difficulty1.horPattern(targetAngle, otherAngle, imgUrl),
          Difficulty1.horPattern(otherAngle, otherAngle, imgUrl),
        ],
      ),
    );
  }

  static SizedBox verPattern(double targetAngle, otherAngle, String imgUrl) {
    return SizedBox(
      width: containerSize * 3,
      height: containerSize * 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Difficulty1.verPattern(otherAngle, otherAngle, imgUrl),
          Difficulty1.verPattern(targetAngle, otherAngle, imgUrl),
          Difficulty1.verPattern(otherAngle, otherAngle, imgUrl),
        ],
      ),
    );
  }

  static SizedBox upArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    return SizedBox(
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
  }

  static SizedBox downArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    return SizedBox(
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
  }

  static SizedBox rightArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    return SizedBox(
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
  }

  static SizedBox leftArrow(
    double targetAngle,
    double otherAngle,
    String imgUrl,
  ) {
    return SizedBox(
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
  }
}
