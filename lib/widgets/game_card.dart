import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GameCard extends StatelessWidget {
  final String routeName;
  final String gameName;
  const GameCard({super.key, required this.routeName, required this.gameName,});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: SizedBox(
        child: Column(
          children: [
            Container(
              width: size.width * 0.4,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                color: Color(0Xff34a0a4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Gap(size.height * 0.01),
            Text(
              gameName,
              style: GlobalVariables.headLineStyle1.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}