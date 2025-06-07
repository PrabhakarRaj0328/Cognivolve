import 'package:cognivolve/utils/global_variables.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PauseOverlay extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onResume;
  final String routeName;

  const PauseOverlay({
    super.key,
    required this.isVisible,
    required this.onResume, required this.routeName,
  });

  @override
  State<PauseOverlay> createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(covariant PauseOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder:
          (_, __) => SlideTransition(
            position: _animation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 170,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: GlobalVariables.iconColor,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Paused",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: GlobalVariables.iconColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: widget.onResume,
                              icon: Icon(
                                FluentSystemIcons.ic_fluent_play_filled,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Gap(15),
                          Container(
                            decoration: BoxDecoration(
                              color: GlobalVariables.iconColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () async {
                                Navigator.pushReplacementNamed(
                                  context,
                                  widget.routeName,
                                );
                              },
                              icon: Icon(
                                FluentSystemIcons
                                    .ic_fluent_arrow_clockwise_filled,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Gap(15),
                          Container(
                            decoration: BoxDecoration(
                              color: GlobalVariables.iconColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
