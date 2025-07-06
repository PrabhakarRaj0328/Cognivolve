import 'package:cognivolve/services/auth.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthScreen extends StatefulWidget {
  static const routName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _googleAuthService = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = AppLayout.getSize(context).width;
    double height = AppLayout.getSize(context).height;
    return Scaffold(
      backgroundColor: GlobalVariables.bgColor,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text('Sign in to train your brain', style: TextStyle(fontSize: 18)),
            Gap(height * 0.02),
            GestureDetector(
              onTap: () async {
                final user = await _googleAuthService.signInWithGoogle();
                if (user != null) {
                  print("Signed in as: ${user.displayName}, ${user.email}");
                  // For example, navigate to home screen:
                  // Navigator.pushReplacementNamed(context, '/home');
                } else {
                  print("Google sign-in failed or was canceled.");
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: width * 0.65,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Gap(10),
                      Text(
                        'Continue with Google',
                        style: GlobalVariables.headLineStyle1.copyWith(
                          fontSize: 20,
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
