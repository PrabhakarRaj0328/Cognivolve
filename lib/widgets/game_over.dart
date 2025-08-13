import 'package:cognivolve/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget showGameOver(int text,BuildContext context,String routeName) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 35,right: 35,top: 35),
      child: Container(
        height: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: GlobalVariables.iconColor, width: 10),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nice going! You earned \n$text points',
              style: GlobalVariables.headLineStyle1.copyWith(fontSize: 19),
              textAlign: TextAlign.center,
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(
                        context,
                        routeName,
                      );
                    },
                    icon: Icon(
                      Icons.restart_alt,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, size: 35, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
