part of 'game_bloc.dart';

sealed class GameState {}

final class GameInProgress extends GameState {

  final String meaning;
  final String meaningColor;
  final String text;
  final String textColor;
  final int score;
  final bool ans;
  GameInProgress(this.meaning, this.text, this.score, this.ans, this.meaningColor, this.textColor);
}
final class GameOver extends GameState {
  final int score;
  GameOver(this.score);
}
