import 'package:flutter/material.dart';

class SignInLoader extends StatefulWidget {
  const SignInLoader({super.key});

  @override
  State<SignInLoader> createState() => _SignInLoaderState();
}

class _SignInLoaderState extends State<SignInLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
          ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(0),
                _buildDot(1),
                _buildDot(2),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Signing you in...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
