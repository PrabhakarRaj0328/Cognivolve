import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cognivolve/blocs/corsi_span_task/countdown_bloc/countdown_bloc.dart';
import 'package:cognivolve/blocs/corsi_span_task/game_bloc/game_bloc.dart';
import 'package:cognivolve/blocs/corsi_span_task/timer_bloc/timer_bloc.dart';
import 'package:cognivolve/screens/games/corsi_span_task/widgets.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:cognivolve/utils/layout.dart';
import 'package:cognivolve/widgets/game_over.dart';
import 'package:cognivolve/widgets/pause_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:logger/web.dart';

class CorsiSpanTask extends StatefulWidget {
  static const String routeName = '/corsi_span_task';
  const CorsiSpanTask({super.key});

  @override
  State<CorsiSpanTask> createState() => _CorsiSpanTaskState();
}

class _CorsiSpanTaskState extends State<CorsiSpanTask> {
  final Logger logger = Logger();

  // Data collection variables
  List<CorsiTrialData> trialsData = [];
  int currentTrialNumber = 0;
  DateTime? trialStartTime;
  String gameSessionId = '';
  bool? isReversed;

  @override
  void initState() {
    super.initState();
    gameSessionId = 'corsi_${DateTime.now().millisecondsSinceEpoch}';
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  // Initialize new trial
  void startNewTrial() {
    currentTrialNumber++;
    trialStartTime = DateTime.now();
  }

  // Record trial data
  void recordTrialData(
    List<int> target,
    List<int> userResponse,
    bool isCorrect,
    int sequenceLength,
  ) {
    if (trialStartTime != null) {
      final reactionTime =
          DateTime.now().difference(trialStartTime!).inMilliseconds;

      final trial = CorsiTrialData(
        trialNumber: currentTrialNumber,
        target: target,
        isReversed: isReversed!,
        userResponse: userResponse,
        isCorrect: isCorrect,
        reactionTime: reactionTime,
        sequenceLength: sequenceLength,
        timestamp: DateTime.now(),
      );

      trialsData.add(trial);
    }
  }

  // Push data to Firebase
  Future<void> pushDataToFirebase(int finalScore) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        logger.e('No authenticated user found');
        return;
      }

      final gameData = {
        'gameType': 'corsi_span_task',
        'sessionId': gameSessionId,
        'finalScore': finalScore,
        'totalTrials': trialsData.length,
        'gameStartTime':
            trialsData.isNotEmpty
                ? trialsData.first.timestamp.toIso8601String()
                : DateTime.now().toIso8601String(),
        'gameEndTime': DateTime.now().toIso8601String(),
        'trials': trialsData.map((trial) => trial.toJson()).toList(),
      };

      // Push to user's game collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('games')
          .doc(gameSessionId)
          .set(gameData);

      // Update user statistics
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'gamesPlayed': FieldValue.increment(1),
            'totalScore': FieldValue.increment(finalScore),
            'lastGamePlayed': FieldValue.serverTimestamp(),
          });

      logger.i('Corsi Span task data successfully pushed to Firebase');
    } catch (e) {
      logger.e('Error pushing data to Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    double gridSize = size.width * 0.7;
    int rows = 3;

    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CountdownBloc()..add(StartCountdown())),
          BlocProvider(create: (_) => TimerBloc()),
          BlocProvider(create: (_) => GameBloc()),
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.08),
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
                                BlocBuilder<CountdownBloc, CountdownState>(
                                  builder: (context, state) {
                                    return Opacity(
                                      opacity:
                                          state is CountdownComplete ? 1 : 0,
                                      child: Container(
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
                                    );
                                  },
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
                            if (state.isOver) {
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
                          context.read<TimerBloc>().add(TimerStart(90));
                          context.read<GameBloc>().add(StartGame());

                          startNewTrial();
                          return BlocBuilder<GameBloc, GameState>(
                            builder: (context, state) {
                              if (state is GameInProgress) {
                                isReversed = state.isReversed;
                                if (state.isCorrect != -1) {
                                  recordTrialData(
                                    state.sequence,
                                    state.userInput,
                                    state.isCorrect == 1,
                                    state.currentLength,
                                  );
                                  startNewTrial();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.08,
                                      ),
                                      child: SizedBox(
                                        width: gridSize,
                                        height: gridSize + 50,
                                        child: buildGrid(
                                          rows,
                                          state.highlightedIndex ?? -1,
                                          state.cueColor,
                                        ),
                                      ),
                                    ),
                                    state.showGo
                                        ? Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: GlobalVariables.mainColor,
                                          ),

                                          child: Text(
                                            'Go!',
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                        : SizedBox.shrink(),
                                    Center(
                                      child:
                                          state.isCorrect != -1
                                              ? Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      state.isCorrect == 1
                                                          ? Color(0xFF38b000)
                                                          : Color(0Xffef233c),
                                                ),
                                                child: Icon(
                                                  state.isCorrect == 1
                                                      ? Icons.check
                                                      : Icons.cancel,
                                                  color: Colors.white,
                                                  size: 80,
                                                ),
                                              )
                                              : SizedBox.shrink(),
                                    ),
                                  ],
                                );
                              } else if (state is GameOver) {
                                pushDataToFirebase(state.finalScore);
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
