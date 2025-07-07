part of 'game_bloc.dart';

sealed class GameState {}

final class GameInProgress extends GameState {
  final List<int> sequence;
  final List<int> userInput;
  final bool acceptingInput;
  final bool isReversed;
  final int isCorrect;
  final int? highlightedIndex;
  final Color cueColor;
  final int score;
  final int currentLength;
  final int incorrect;
  final bool showGo;

  GameInProgress( {
    required this.sequence,
    required this.userInput,
    required this.acceptingInput,
    required this.isReversed,
    required this.highlightedIndex,
    required this.cueColor,
    required this.score,
    required this.currentLength,
    required this.incorrect,
    required this.showGo,
    required this.isCorrect
  });

  factory GameInProgress.initial() {
    return GameInProgress(
      sequence:  [],
      userInput:  [],
      acceptingInput: false,
      isReversed: false,
      highlightedIndex: -1,
      cueColor: const Color(0xFFFFFFFF),
      score: 0,
      currentLength: 2,
      incorrect: 0,
      showGo: false,
      isCorrect: -1
    );
  }

  GameInProgress copyWith({
    List<int>? sequence,
    List<int>? userInput,
    bool? acceptingInput,
    bool? isReversed,
    int? isCorrect,
    int? highlightedIndex,
    Color? cueColor,
    int? score,
    int? incorrect,
    int? currentLength,
    bool? showGo,
  }) {
    return GameInProgress(
      sequence: sequence ?? this.sequence,
      userInput: userInput ?? this.userInput,
      acceptingInput: acceptingInput ?? this.acceptingInput,
      isReversed: isReversed ?? this.isReversed,
      highlightedIndex: highlightedIndex,
      cueColor: cueColor ?? this.cueColor,
      score: score ?? this.score,
      incorrect: incorrect ?? this.incorrect,
      currentLength: currentLength ?? this.currentLength,
      showGo: showGo ?? this.showGo,
      isCorrect: isCorrect ?? this.isCorrect
    );
  }
}

final class GameOver extends GameState{
  final int finalScore;
  GameOver(this.finalScore);
}
