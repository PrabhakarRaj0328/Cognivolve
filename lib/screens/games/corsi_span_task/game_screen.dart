import 'package:cognivolve/blocs/corsi_span_task/countdown_bloc/countdown_bloc.dart';
import 'package:cognivolve/blocs/corsi_span_task/game_bloc/game_bloc.dart';
import 'package:cognivolve/blocs/corsi_span_task/timer_bloc/timer_bloc.dart';
import 'package:cognivolve/screens/games/corsi_span_task/widgets.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:cognivolve/widgets/feedback.dart';
import 'package:cognivolve/widgets/game_over.dart';
import 'package:cognivolve/widgets/pause_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CorsiSpanTask extends StatefulWidget {
  static const String routeName = '/corsi_span_task';
  const CorsiSpanTask({super.key});

  @override
  State<CorsiSpanTask> createState() => _CorsiSpanTaskState();
}

class _CorsiSpanTaskState extends State<CorsiSpanTask> {
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
    double gridSize = size.width * 0.8;
    int rows = 3;

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
                image: AssetImage(
                  'assets/images/corsi_span_task_images/bg.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: BlocBuilder<TimerBloc, TimerState>(
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
                                      context.read<TimerBloc>().add(
                                        PauseTimer(),
                                      );
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
                            if(state.isOver) {
                              context.read<GameBloc>().add(EndGame());
                            }
                            return SizedBox.shrink();
                          }
                          return SizedBox.shrink();
                        },
                      ),
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
                          context.read<TimerBloc>().add(TimerStart(10));
                          context.read<GameBloc>().add(StartGame());
                          return Column(
                            children: [
                              BlocBuilder<GameBloc, GameState>(
                                builder: (context, state) {
                                  if (state is GameInProgress) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 150,
                                        horizontal: 50,
                                      ),
                                      child: SizedBox(
                                        width: gridSize,
                                        height: gridSize,
                                        child: buildGrid(
                                          rows,
                                          state.highlightedIndex ?? -1,
                                          state.cueColor,
                                        ),
                                      ),
                                    );
                                  } else if (state is GameOver) {
                                    context.read<TimerBloc>().add(EndTimer());
                                    return SizedBox(
                                      height: size.height / 2,
                                      child: showGameOver(
                                        state.finalScore,
                                        context,
                                        CorsiSpanTask.routeName,
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                              ),

                              BlocListener<GameBloc, GameState>(
                                listenWhen:
                                    (previous, current) =>
                                        previous is GameInProgress &&
                                        current is GameInProgress &&
                                        (current.message == "correct" ||
                                            current.message == "wrong"),
                                listener: (context, state) {
                                  if (state is GameInProgress) {
                                    showSwipeFeedback(
                                      context,
                                      state.message == "correct",
                                    );
                                  }
                                },
                                child: SizedBox.shrink(),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
                BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    return PauseOverlay(
                      routeName: CorsiSpanTask.routeName,
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
