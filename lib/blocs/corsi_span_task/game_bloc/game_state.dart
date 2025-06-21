part of 'game_bloc.dart';

sealed class GameState {}

final class GameInProgress extends GameState {
  final List<int> sequence;
  final List<int> userInput;
  final bool acceptingInput;
  final bool isReversed;
  final int? highlightedIndex;
  final Color cueColor;
  final int score;
  final String message;
  final int currentLength;
  final int incorrect;

  GameInProgress( {
    required this.message,
    required this.sequence,
    required this.userInput,
    required this.acceptingInput,
    required this.isReversed,
    required this.highlightedIndex,
    required this.cueColor,
    required this.score,
    required this.currentLength,
    required this.incorrect,
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
      message: "",
      currentLength: 2,
      incorrect: 0,
    );
  }

  GameInProgress copyWith({
    List<int>? sequence,
    List<int>? userInput,
    bool? acceptingInput,
    bool? isReversed,
    int? highlightedIndex,
    Color? cueColor,
    String? message,
    int? score,
    int? incorrect,
    int? currentLength,
  }) {
    return GameInProgress(
      sequence: sequence ?? this.sequence,
      userInput: userInput ?? this.userInput,
      acceptingInput: acceptingInput ?? this.acceptingInput,
      isReversed: isReversed ?? this.isReversed,
      highlightedIndex: highlightedIndex,
      cueColor: cueColor ?? this.cueColor,
      message: message ?? this.message,
      score: score ?? this.score,
      incorrect: incorrect ?? this.incorrect,
      currentLength: currentLength ?? this.currentLength,
    );
  }
}

final class GameOver extends GameState{
  final int finalScore;
  GameOver(this.finalScore);
}
