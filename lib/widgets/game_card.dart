import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GameCard extends StatelessWidget {
  final String routeName;
  final String gameName;
  final String imgUrl;

  const GameCard({
    super.key,
    required this.routeName,
    required this.gameName,
    required this.imgUrl,
  });

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
              width: size.width * 0.3,
              height: size.height * 0.18, // a bit taller to fit text
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white, // background for the name area
                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 7,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        "assets/images/$imgUrl",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        gameName,
                        style: GlobalVariables.headLineStyle1.copyWith(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
