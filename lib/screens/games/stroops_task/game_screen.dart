import 'package:cognivolve/blocs/stroops_task_blocs/countdown_bloc/countdown_bloc.dart';
import 'package:cognivolve/blocs/stroops_task_blocs/game_bloc/game_bloc.dart';
import 'package:cognivolve/blocs/stroops_task_blocs/timer_bloc/timer_bloc.dart';
import 'package:cognivolve/widgets/feedback.dart';
import 'package:cognivolve/widgets/pause_overlay.dart';
import 'package:cognivolve/screens/games/stroops_task/services.dart';
import 'package:cognivolve/screens/games/stroops_task/widgets.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:cognivolve/widgets/game_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class StroopsTask extends StatefulWidget {
  static const String routeName = '/stroops_task';
  const StroopsTask({super.key});

  @override
  State<StroopsTask> createState() => _StroopsTaskState();
}

class _StroopsTaskState extends State<StroopsTask> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CountdownBloc()..add(StartCountdown())),
          BlocProvider(create: (_) => TimerBloc()),
          BlocProvider(create: (_) => GameBloc()),
        ],
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/stroops_task_images/wood.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                        if (state is TimerInProgress) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF353535),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    context.read<TimerBloc>().add(PauseTimer());
                                  },
                                  icon: Icon(
                                    Icons.pause,
                                    color: GlobalVariables.gameColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
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
                                            style: GlobalVariables
                                                .headLineStyle1
                                                .copyWith(
                                                  color:
                                                      GlobalVariables
                                                          .brownColor,
                                                  fontSize: 17,
                                                ),
                                          ),
                                          Gap(8),
                                          Text(
                                            '${state.timeRemaing}',
                                            style: GlobalVariables
                                                .headLineStyle1
                                                .copyWith(
                                                  color:
                                                      GlobalVariables
                                                          .brownColor,
                                                  fontSize: 17,
                                                ),
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
                                            style: GlobalVariables
                                                .headLineStyle1
                                                .copyWith(
                                                  color:
                                                      GlobalVariables
                                                          .brownColor,
                                                  fontSize: 17,
                                                ),
                                          ),
                                          BlocBuilder<GameBloc, GameState>(
                                            builder: (context, state) {
                                              if (state is GameInProgress) {
                                                return Text(
                                                  '${state.score}',
                                                  style: GlobalVariables
                                                      .headLineStyle1
                                                      .copyWith(
                                                        color:
                                                            GlobalVariables
                                                                .brownColor,
                                                        fontSize: 17,
                                                      ),
                                                );
                                              }
                                              return SizedBox.shrink();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else if (state is TimerEnded) {
                          context.read<GameBloc>().add(EndGame());
                          return SizedBox.shrink();
                        }
                        return SizedBox.shrink();
                      },
                    ),

                    BlocBuilder<CountdownBloc, CountdownState>(
                      builder: (context, state) {
                        if (state is CountdownInProgress) {
                          return Expanded(
                            child: Center(
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
                            ),
                          );
                        } else {
                          context.read<TimerBloc>().add(TimerStart(45));
                          context.read<GameBloc>().add(StartGame());
                          return BlocBuilder<GameBloc, GameState>(
                            builder: (context, state) {
                              if (state is GameInProgress) {
                                return Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Does the meaning match the text color?',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Gap(20),
                                      descCard('meaning'),
                                      CustomPaint(
                                        size: Size(20, 10),
                                        painter: DownTrianglePainter(),
                                      ),
                                      Gap(3),
                                      Container(
                                        width: size.width * 0.65,
                                        height: size.width * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                0,
                                                0,
                                                0,
                                                0.6,
                                              ),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.meaning,
                                            style: TextStyle(
                                              color:
                                                  colorMap[state.meaningColor],
                                              fontSize: 55,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gap(15),
                                      Container(
                                        width: size.width * 0.65,
                                        height: size.width * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                0,
                                                0,
                                                0,
                                                0.6,
                                              ),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.text,
                                            style: TextStyle(
                                              color: colorMap[state.textColor],
                                              fontSize: 55,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gap(3),
                                      CustomPaint(
                                        size: Size(20, 10),
                                        painter: UpTrianglePainter(),
                                      ),
                                      descCard('text color'),
                                    ],
                                  ),
                                );
                              } else if (state is GameOver) {
                                return Expanded(
                                  child: showGameOver(
                                    state.score,
                                    context,
                                    StroopsTask.routeName,
                                  ),
                                );
                              }
                              return SizedBox.shrink();
                            },
                          );
                        }
                      },
                    ),
                    BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        if (state is GameInProgress) {
                          return Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    final bool isCorrect = state.ans == false;
                                    showSwipeFeedback(context, isCorrect);
                                    context.read<GameBloc>().add(
                                      UserResponse(isCorrect),
                                    );
                                  },
                                  child: Container(
                                    height: size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'NO',
                                        style: TextStyle(
                                          color: GlobalVariables.gameColor,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(3),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    final bool isCorrect = state.ans == true;
                                    showSwipeFeedback(context, isCorrect);
                                    context.read<GameBloc>().add(
                                      UserResponse(isCorrect),
                                    );
                                  },
                                  child: Container(
                                    height: size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'YES',
                                        style: TextStyle(
                                          color: GlobalVariables.gameColor,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),

                BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    return PauseOverlay(
                      routeName: StroopsTask.routeName,
                      isVisible: state is TimerPaused,
                      onResume: () {
                        context.read<TimerBloc>().add(ResumeTimer());
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
