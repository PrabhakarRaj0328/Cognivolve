import 'package:cognivolve/screens/games/corsi_span_task/corsi_desc.dart';
import 'package:cognivolve/screens/games/flankers_task/desc_screen.dart';
import 'package:cognivolve/screens/games/stroops_task/desc_screen.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:cognivolve/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = AppLayout.getSize(context);
    return  SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.03,
          ),
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Games', style: GlobalVariables.headLineStyle1),
                  Gap(size.height * 0.02),
                  SingleChildScrollView(
                  
                    scrollDirection: Axis.horizontal,
                    
                    child: Row(
                      children: [
                        GameCard(
                          routeName: FlankersTaskDesc.routeName,
                          gameName: 'Flanker\'s Task',
                        ),
                        Gap(15),
                        GameCard(
                          routeName: StroopDesc.routeName,
                          gameName: 'Stroop\'s Task',
                        ),
                        Gap(15),
                        GameCard(
                          routeName: CorsiDesc.routeName,
                          gameName: 'Corsi\'s Task',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    
    );
  }
}
