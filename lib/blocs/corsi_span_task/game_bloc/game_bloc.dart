import 'dart:math';
import 'package:cognivolve/screens/games/corsi_span_task/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  static const int maxIndex = 9;
  GameBloc() : super(GameInProgress.initial()) {
    on<StartGame>((event, emit) {
      List<int> currSequence = generateSequence(2, maxIndex);
      final bool isReversed = Random().nextBool();
      final Color cueColor = isReversed ? Colors.red : Colors.yellow;
      final currState = state as GameInProgress;

      emit(
        currState.copyWith(
          sequence: currSequence,
          isReversed: isReversed,
          cueColor: cueColor,
        ),
      );

      add(ShowNextSequence());
    });

    on<BlockTapped>((event, emit) async {
      var currState = state as GameInProgress;
      if (!currState.acceptingInput) return;

      final updatedInput = List<int>.from(currState.userInput)
        ..add(event.index);

      emit(currState.copyWith(userInput: updatedInput));

      currState = state as GameInProgress;

      emit(currState.copyWith(highlightedIndex: event.index));
      await Future.delayed(Duration(milliseconds: 100));
      emit(currState.copyWith(highlightedIndex: null));

      if (updatedInput.length == currState.sequence.length) {
        final expected =
            currState.isReversed
                ? currState.sequence.reversed.toList()
                : currState.sequence;

        bool isCorrect = compareLists(updatedInput, expected);

        emit(
          currState.copyWith(
            isCorrect: isCorrect?1:0,
            acceptingInput: false,
            score: isCorrect ? currState.score + 100 : currState.score,
            incorrect:
                isCorrect ? currState.incorrect : currState.incorrect + 1,
            currentLength:
                isCorrect
                    ? currState.currentLength + 1
                    : currState.currentLength,
          ),
        );
        await Future.delayed(Duration(milliseconds: 300));
        currState = state as GameInProgress;
        emit(
          currState.copyWith(
            isCorrect: -1,
          ),
        );
        currState = state as GameInProgress;
        if (currState.currentLength == 10 || currState.incorrect == 3) {
          await Future.delayed(Duration(milliseconds: 500));
          add(EndGame());
        } else {
          Future.delayed(Duration(seconds: 1), () {
            add((NextRound()));
          });
        }
      }
    });

    on<ShowNextSequence>((event, emit) async {
      final currState = state as GameInProgress;

      for (int index in currState.sequence) {
        emit(currState.copyWith(highlightedIndex: index));
        await Future.delayed(Duration(milliseconds: 500));
        emit(currState.copyWith(highlightedIndex: -1));
        await Future.delayed(Duration(milliseconds: 150));
      }
      emit(currState.copyWith(acceptingInput: true, showGo: true));
      await Future.delayed(Duration(milliseconds: 300));
      emit(currState.copyWith(acceptingInput: true,showGo: false));

    });

    on<NextRound>((event, emit) {
      final currState = state as GameInProgress;

      List<int> currSequence = generateSequence(
        currState.currentLength,
        maxIndex,
      );
      emit(
        currState.copyWith(
          sequence: currSequence,
          isReversed: currState.isReversed,
          userInput: [],
          highlightedIndex: -1,
          cueColor: currState.cueColor,
        ),
      );
      add(ShowNextSequence());
    });

    on<EndGame>((event, emit) {
      final currState = state as GameInProgress;
      emit(GameOver(currState.score));
    });
  }
}
