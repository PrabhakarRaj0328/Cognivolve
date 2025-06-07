import 'dart:math';
import 'dart:ui';
import 'package:cognivolve/blocs/flankers_task_blocs/countdown_bloc.dart/countdown_bloc.dart';
import 'package:cognivolve/blocs/flankers_task_blocs/game_bloc/game_bloc.dart';
import 'package:cognivolve/blocs/flankers_task_blocs/phase_bloc/phase_bloc.dart';
import 'package:cognivolve/blocs/flankers_task_blocs/timer_bloc.dart/timer_bloc.dart';
import 'package:cognivolve/screens/games/flankers_task/patterns.dart';
import 'package:cognivolve/widgets/pause_overlay.dart';
import 'package:cognivolve/screens/games/flankers_task/services.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:cognivolve/widgets/feedback.dart';
import 'package:cognivolve/widgets/game_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FlankersTask extends StatefulWidget {
  static const String routeName = '/flankers_task';

  const FlankersTask({super.key});

  @override
  State<FlankersTask> createState() => _FlankersTaskState();
}

class _FlankersTaskState extends State<FlankersTask>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<Offset> currentDirection;
  late Map<String, String> currentImagePair;
  final List<int> speed = [2, 3];

  late List<Map<String, String>> gameSessionPairs;
  bool start = true;
  bool change = true;

  static List<List<Offset>> directions = [
    [Offset(-1.2, 0), Offset(1.2, 0)], // Left to Right
    [Offset(1.2, 0), Offset(-1.2, 0)], // Right to Left
    [Offset(0, -1.2), Offset(0, 1.2)], // Top to Bottom
    [Offset(0, 1.2), Offset(0, -1.2)], // Bottom to Top
    [Offset(-1.2, -1.2), Offset(1.2, 1.2)], // TL to BR
    [Offset(1.2, 1.2), Offset(-1.2, -1.2)], // BR to TL
    [Offset(1.2, -1.2), Offset(-1.2, 1.2)], // TR to BL
    [Offset(-1.2, 1.2), Offset(1.2, -1.2)], // BL to TR
  ];

  void setNewDirection() {
    final rand = Random();
    currentDirection = directions[rand.nextInt(directions.length)];
    _controller.reset();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var currentPath in images) {
        precacheImage(
          AssetImage('assets/images/${currentPath['bgUrl']}'),
          context,
        );
        precacheImage(
          AssetImage('assets/images/${currentPath['imgUrl']}'),
          context,
        );
      }
    });
    _controller = AnimationController(
      duration: Duration(seconds: speed[Random().nextInt(speed.length)]),
      vsync: this,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    currentImagePair = images[0];

    final size = AppLayout.getSize(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PhaseBloc()..add(PhaseChange(currentImagePair)),
        ),
        BlocProvider(create: (_) => CountdownBloc()..add(StartCountdown())),
        BlocProvider(create: (_) => TimerBloc()),
        BlocProvider(create: (_) => GameBloc()),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.08),
          child: Stack(
            children: [
              BlocBuilder<PhaseBloc, PhaseState>(
                builder: (context, state) {
                  return Container(
                    height: double.infinity,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/${currentImagePair['bgUrl']}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              Column(
                children: [
                  BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      if (state is TimerInProgress) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF16697a),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  context.read<TimerBloc>().add(PauseTimer());
                                  _controller.stop();
                                },
                                icon: Icon(
                                  Icons.pause,
                                  color: GlobalVariables.gameColor,
                                ),
                              ),
                            ),
                            Gap(95),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 0.26,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFe5e5e5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'TIME',
                                        style: GlobalVariables.headLineStyle1
                                            .copyWith(fontSize: 17),
                                      ),
                                      Gap(8),
                                      BlocBuilder<TimerBloc, TimerState>(
                                        builder: (context, state) {
                                          if (state is TimerInProgress) {
                                            return Text(
                                              '${state.timeRemaing}',
                                              style: GlobalVariables
                                                  .headLineStyle1
                                                  .copyWith(fontSize: 17),
                                            );
                                          } else if (state is TimerEnded) {
                                            return Text(
                                              'End',
                                              style: GlobalVariables
                                                  .headLineStyle1
                                                  .copyWith(fontSize: 17),
                                            );
                                          }
                                          return SizedBox.shrink();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(3),
                                Container(
                                  width: size.width * 0.34,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFe5e5e5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'SCORE',
                                        style: GlobalVariables.headLineStyle1
                                            .copyWith(fontSize: 17),
                                      ),
                                      BlocBuilder<GameBloc, GameState>(
                                        builder: (context, state) {
                                          if (state is GameInProgress) {
                                            return Text(
                                              '${state.score}',
                                              style: GlobalVariables
                                                  .headLineStyle1
                                                  .copyWith(fontSize: 17),
                                            );
                                          }
                                          return Text('Over');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (state is TimerEnded) {
                        _controller.dispose();
                        context.read<GameBloc>().add(GameOverEvent());
                        return SizedBox.shrink();
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<CountdownBloc, CountdownState>(
                      builder: (context, state) {
                        if (state is CountdownInProgress) {
                          return Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: GlobalVariables.secondaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  '${state.secondsRemaining}',
                                  style: TextStyle(
                                    fontSize: 60,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (state is CountdownComplete) {
                          int randSpeed = speed[Random().nextInt(speed.length)];
                          _controller.duration = Duration(seconds: randSpeed);

                          _animation = Tween<double>(
                            begin: 0,
                            end: 1,
                          ).animate(_controller);

                          _controller.addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              currentImagePair = GamePhaseManager.getRandomPair(
                                images,
                              );
                              context.read<PhaseBloc>().add(
                                PhaseChange(currentImagePair),
                              );

                              context.read<GameBloc>().add(
                                UserSwiped('none', currentImagePair['imgUrl']!),
                              );
                              setNewDirection();
                              _controller.forward(from: 0);
                            }
                          });
                          _controller.reset();

                          context.read<TimerBloc>().add(TimerStart(45));
                          context.read<GameBloc>().add(
                            StartGame(currentImagePair['imgUrl']!),
                          );

                          setNewDirection();
                          _controller.forward();

                          start = false;
                          return BlocBuilder<GameBloc, GameState>(
                            builder: (context, state) {
                              if (state is GameInProgress) {
                                return GestureDetector(
                                  onHorizontalDragEnd: (details) async {
                                    _controller.stop();
                                    currentImagePair =
                                        GamePhaseManager.getRandomPair(images);

                                    context.read<PhaseBloc>().add(
                                      PhaseChange(currentImagePair),
                                    );
                                    setNewDirection();
                                    _controller.forward();
                                    final dx =
                                        details.velocity.pixelsPerSecond.dx;
                                    String swipeDir = dx > 0 ? 'right' : 'left';
                                    showSwipeFeedback(
                                      context,
                                      state.targetDirection == swipeDir,
                                    );
                                    context.read<GameBloc>().add(
                                      UserSwiped(
                                        swipeDir,
                                        currentImagePair['imgUrl']!,
                                      ),
                                    );
                                  },
                                  onVerticalDragEnd: (details) {
                                    _controller.stop();
                                    setNewDirection();
                                    currentImagePair =
                                        GamePhaseManager.getRandomPair(images);

                                    context.read<PhaseBloc>().add(
                                      PhaseChange(currentImagePair),
                                    );
                                    _controller.forward();
                                    final dy =
                                        details.velocity.pixelsPerSecond.dy;

                                    String swipeDir = dy > 0 ? 'down' : 'up';
                                    showSwipeFeedback(
                                      context,
                                      state.targetDirection == swipeDir,
                                    );
                                    context.read<GameBloc>().add(
                                      UserSwiped(
                                        swipeDir,
                                        currentImagePair['imgUrl']!,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(),
                                    width: size.width,
                                    height: size.height * 0.78,
                                    child: Stack(
                                      children: [
                                        AnimatedBuilder(
                                          animation: _animation,
                                          builder: (context, child) {
                                            final box =
                                                state.currentPattern
                                                    as SizedBox;
                                            double patternWidth = box.width!;
                                            double patternHeight = box.height!;

                                            double startX =
                                                size.width / 2 +
                                                currentDirection[0].dx *
                                                    (size.width);
                                            double startY =
                                                size.width / 2 +
                                                currentDirection[0].dy *
                                                    (size.height * 0.78);

                                            double endX =
                                                size.width / 2 +
                                                currentDirection[1].dx *
                                                    (size.width);
                                            double endY =
                                                size.height * 0.76 / 2 +
                                                currentDirection[1].dy *
                                                    (size.height * 0.78);

                                            final left =
                                                lerpDouble(
                                                  startX,
                                                  endX,
                                                  _animation.value,
                                                )! -
                                                patternWidth / 2;
                                            final top =
                                                lerpDouble(
                                                  startY,
                                                  endY,
                                                  _animation.value,
                                                )! -
                                                patternHeight / 2;
                                            return Stack(
                                              children: [
                                                Positioned(
                                                  left: left,
                                                  top: top,
                                                  child: child!,
                                                ),
                                              ],
                                            );
                                          },
                                          child: state.currentPattern,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (state is GameOver) {
                                return showGameOver(state.finalScore, context,FlankersTask.routeName);
                              }
                              return SizedBox.shrink();
                            },
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
              BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  return PauseOverlay(
                    routeName: FlankersTask.routeName,
                    isVisible: state is TimerPaused,
                    onResume: () {
                      context.read<TimerBloc>().add(ResumeTimer());
                      _controller.forward();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
