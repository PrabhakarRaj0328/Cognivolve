import 'package:cognivolve/utils/global_variables.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  final String routeName;
  const InfoScreen({super.key,required this.routeName});

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
                  Navigator.pushNamed(context, widget.routeName,
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
