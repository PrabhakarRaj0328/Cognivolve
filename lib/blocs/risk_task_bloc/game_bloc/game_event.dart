part of 'game_bloc.dart';

sealed class GameEvent {}

final class StartGame extends GameEvent{}
final class UserResponse extends GameEvent{
  final bool isCorrect;
  UserResponse(this.isCorrect);
}
final class EndGame extends GameEvent{}
