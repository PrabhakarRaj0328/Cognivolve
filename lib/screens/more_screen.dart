// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'package:cognivolve/screens/auth_screen.dart';
import 'package:cognivolve/services/auth.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authservice = AuthService();
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () async {
            await _authservice.signOut();
            Navigator.pushReplacementNamed(
              context,
              AuthScreen.routeName,
            );
          },
          child: Center(child: Container(
            height: 50,width: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: GlobalVariables.primaryColor), child: Center(child: Text('Sign out',style: TextStyle(color: Colors.white, fontSize: 20),)))),
        ),
      ),
    );
  }
}
