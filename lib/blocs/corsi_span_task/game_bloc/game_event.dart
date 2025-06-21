part of 'game_bloc.dart';

sealed class GameEvent {}

final class StartGame extends GameEvent {}
final class ShowNextSequence extends GameEvent {}
final class NextRound extends GameEvent {}
final class BlockTapped extends GameEvent {
  final int index;
  BlockTapped(this.index);
}

final class EndGame extends GameEvent {}
