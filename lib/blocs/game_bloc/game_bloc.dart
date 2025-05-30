import 'dart:math';
import 'package:cognivolve/screens/games/flankers_task/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final Random random = Random();

  GameBloc() : super(GameInProgress(SizedBox.shrink(), 'null',0)) {
    on<StartGame>((event, emit) {
      final PatternResult pattern = FlankersTaskServices.randomPattern(
        event.imgUrl,
      );
      emit(GameInProgress(pattern.pattern, pattern.direction, 0));
    });
    on<UserSwiped>((event, emit) {
      final PatternResult newPattern = FlankersTaskServices.randomPattern(
        event.imgUrl,
      );

      if (state is GameInProgress) {
        final current = state as GameInProgress;

        if (event.direction == 'none') {
          emit(
            GameInProgress(
              newPattern.pattern,
              newPattern.direction,
              current.score,

            ),
          );
        } else if (event.direction == current.targetDirection) {
          emit(
            GameInProgress(
              newPattern.pattern,
              newPattern.direction,
              current.score + 100            ),
          );
        } else {
          emit(
            GameInProgress(
              newPattern.pattern,
              newPattern.direction,
              current.score,
            ),
          );
        }
      }
    });
    on<GameFinished>((event, emit) {
      if (state is GameInProgress) {
        final current = state as GameInProgress;
        emit(GameOver(current.score));
      }
    });
  }
}
