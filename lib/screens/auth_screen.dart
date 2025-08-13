// ignore_for_file: use_build_context_synchronously

import 'package:cognivolve/screens/info_form.dart';
import 'package:cognivolve/screens/loader.dart';
import 'package:cognivolve/services/auth.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logger/web.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService authService = AuthService();
  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  Future<void> _handleGoogleSignIn() async {
    // Show loader
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        barrierDismissible: false,
        builder: (_) => const SignInLoader(),
      ),
    );

    final user = await authService.signInWithGoogle();

    // Close loader
    Navigator.pop(context);

    if (user != null) {
      bool isNew = await authService.isNewUser(user.uid);
      if (isNew) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => UserInfoForm(
              uid: user.uid,
              email: user.email!,
              displayName: user.displayName ?? '',
            ),
          ),
        );
      } else {
        Navigator.pushReplacementNamed(context, '/landingpage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = AppLayout.getSize(context).width;
    double height = AppLayout.getSize(context).height;
    return Scaffold(
      backgroundColor: const Color(0xffedf6f9),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text('Sign in to train your brain', style: TextStyle(fontSize: 16)),
            Gap(height * 0.02),
            GestureDetector(
              onTap: _handleGoogleSignIn,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: width * 0.65,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'Continue with Google',
                        style: GlobalVariables.headLineStyle1.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ],
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
