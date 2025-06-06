part of 'game_bloc.dart';


sealed class GameState {}

final class GameInProgress extends GameState {
  final Widget currentPattern;
  final String targetDirection;
  final int score;

  GameInProgress(this.currentPattern, this.targetDirection, this.score);
}

final class GamePaused extends GameState {}

final class GameOver extends GameState {
  final int finalScore;
  GameOver(this.finalScore);
}
