  import 'package:flutter/material.dart';

void showSwipeFeedback(BuildContext context, bool isCorrect) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCorrect ? Color(0xFF38b000) : Color(0Xffef233c),
              ),
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 300),
                child: Icon(
                  isCorrect ? Icons.check : Icons.cancel,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(milliseconds: 300), () {
      overlayEntry.remove();
    });
  }