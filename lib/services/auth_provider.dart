import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      notifyListeners();
    });
  }

  bool get isLoggedIn => user != null;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
