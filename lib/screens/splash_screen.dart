import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cognivolve/screens/auth_gate.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = AppLayout.getSize(context).height;
    
    return AnimatedSplashScreen(
      duration: 3000,
      splashIconSize: height,
      backgroundColor: Color(0xfff7ede2),
      splash: Column(
        children: [
          Gap(height*0.2),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(height*0.1),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(GlobalVariables.mainColor),
          ),
        ],
      ),
      nextScreen: AuthGate(),
      splashTransition: SplashTransition.fadeTransition,
     
    );
  }
}
