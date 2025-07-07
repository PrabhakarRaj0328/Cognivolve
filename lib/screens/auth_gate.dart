import 'package:cognivolve/screens/auth_screen.dart';
import 'package:cognivolve/screens/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return AuthScreen();
    } else {
      return LandingPage();
    }
  }
}
