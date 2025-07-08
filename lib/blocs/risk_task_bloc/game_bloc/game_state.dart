part of 'game_bloc.dart';

sealed class GameState {}

final class GameInProgress extends GameState {
  final List<int> digits;
  final int correctDigit;
  final int isCorrect;
  final int score;
  final int hiddenIndex;

  GameInProgress({
    required this.digits,
    required this.correctDigit,
    required this.score,
    required this.hiddenIndex,
    required this.isCorrect,
  });

  factory GameInProgress.initial() {
    return GameInProgress(
      digits: [],
      correctDigit: 0,
      score: 0,
      hiddenIndex: -1,
      isCorrect: -1,
    );
  }

  GameInProgress copyWith({
    List<int>? digits,
    int? correctDigit,
    int? isCorrect,
    int? score,
    int? hiddenIndex,
  }) {
    return GameInProgress(
      digits: digits ?? this.digits,
      correctDigit: correctDigit ?? this.correctDigit,
      score: score ?? this.score,
      hiddenIndex: hiddenIndex ?? this.hiddenIndex,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}

final class GameOver extends GameState {
  final int score;
  GameOver(this.score);
}
