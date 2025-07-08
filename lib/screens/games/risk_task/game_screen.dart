import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cognivolve/blocs/risk_task_bloc/countdown_bloc/countdown_bloc.dart';
import 'package:cognivolve/blocs/risk_task_bloc/game_bloc/game_bloc.dart';
import 'package:cognivolve/screens/games/risk_task/widgets.dart';
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

import '../../../blocs/risk_task_bloc/timer_bloc/timer_bloc.dart';

class RiskGameScreen extends StatefulWidget {
  static const routeName = '/risk_task';
  const RiskGameScreen({super.key});

  @override
  State<RiskGameScreen> createState() => _RiskGameScreenState();
}

class _RiskGameScreenState extends State<RiskGameScreen> {
  final Logger logger = Logger();

  // Data collection variables
  List<RiskTrialData> trialsData = [];
  int currentTrialNumber = 0;
  DateTime? trialStartTime;
  String gameSessionId = '';
  @override
  void initState() {
    super.initState();
    gameSessionId = 'risk_${DateTime.now().millisecondsSinceEpoch}';
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void startNewTrial() {
    currentTrialNumber++;
    trialStartTime = DateTime.now();
  }

  // Record trial data
  void recordTrialData(
    List<int> digits,
    int hiddenIndex,
    int correctDigit,
    int userResponse,
    bool isCorrect,
  ) {
    if (trialStartTime != null) {
      final reactionTime =
          DateTime.now().difference(trialStartTime!).inMilliseconds;

      final trial = RiskTrialData(
        trialNumber: currentTrialNumber,
        digits: digits,
        hiddenIndex: hiddenIndex,
        correctDigit: correctDigit,
        userResponse: userResponse,
        isCorrect: isCorrect,
        reactionTime: reactionTime,
        timestamp: DateTime.now(),
      );

      trialsData.add(trial);
      logger.i(
        'Trial currentTrialNumber recorded: ${isCorrect ? "Correct" : "Incorrect"}',
      );
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
        'gameType': 'risk_task',
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
      logger.i('Risk task data successfully pushed to Firebase');
    } catch (e) {
      logger.e('Error pushing data to Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CountdownBloc()..add(StartCountdown())),
          BlocProvider(create: (_) => TimerBloc()),
          BlocProvider(create: (_) => GameBloc()),
        ],
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.08),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/risk_task_images/bg.jpg'),
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
                            context.read<TimerBloc>().add(TimerStart(35));
                            context.read<GameBloc>().add(StartGame());

                            startNewTrial();
                            return BlocBuilder<GameBloc, GameState>(
                              builder: (context, state) {
                                if (state is GameInProgress) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.1,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        LotteryTicket(
                                          numbers: state.digits,
                                          hiddenIndex: state.hiddenIndex,
                                        ),
                                        ChoiceButtons(
                                          digit1: 4,
                                          digit2: 5,
                                          onChoice: (int num) {
                                            final bool isCorrect =
                                                num == state.correctDigit;

                                            // Record trial data
                                            recordTrialData(
                                              state.digits,
                                              state.hiddenIndex,
                                              state.correctDigit,
                                              num,
                                              isCorrect,
                                            );
                                            context.read<GameBloc>().add(
                                              UserResponse(isCorrect),
                                            );
                                            // Start new trial
                                            startNewTrial();
                                          },
                                        ),
                                        state.isCorrect != -1
                                            ? Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    state.isCorrect == 1
                                                        ? Color(0xFF38b000)
                                                        : Color(0Xffef233c),
                                              ),
                                              child: Text(
                                                state.isCorrect == 1
                                                    ? '+100\$'
                                                    : '0\$',
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  );
                                } else {
                                  if (state is GameOver) {
                                    pushDataToFirebase(state.score);
                                    return SizedBox(
                                      height: size.height / 2,
                                      child: showGameOver(
                                        state.score,
                                        context,
                                        RiskGameScreen.routeName,
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                }
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
                        routeName: RiskGameScreen.routeName,
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
      ),
    );
  }
}
