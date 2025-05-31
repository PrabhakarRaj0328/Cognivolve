// ignore_for_file: use_build_context_synchronously

import 'package:cognivolve/screens/games/flankers_task/game_screen.dart';
import 'package:cognivolve/screens/games/flankers_task/patterns.dart';
import 'package:cognivolve/screens/games/flankers_task/services.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cognivolve',
          style: GlobalVariables.headLineStyle1.copyWith(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: GlobalVariables.secondaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xFFe9ecef)),
              child: GestureDetector(
                onTap: () async{
                  final List<Map<String,String>> selectedImages = GamePhaseManager.getRandomThreePairs(images);

                  for(int i=0;i<selectedImages.length;i++){
                    print(selectedImages);
                    await precacheImage(AssetImage('assets/images/${selectedImages[i]['bgUrl']}'), context);
                    if (!mounted) return;
                    await precacheImage(AssetImage('assets/images/${selectedImages[i]['imgUrl']}'), context);
                    if (!mounted) return;
                  }
                  Navigator.pushNamed(context, FlankersTask.routeName,
                  arguments:selectedImages,
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    decoration: BoxDecoration(
                      color: GlobalVariables.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Start',
                      style: GlobalVariables.headLineStyle1.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
