part of 'game_bloc.dart';


sealed class GameEvent {}

final class StartGame extends GameEvent{
  final String imgUrl;
  StartGame(this.imgUrl);
}
final class UserSwiped extends GameEvent{
  final String direction;
  final String imgUrl;
  UserSwiped(this.direction,this.imgUrl);
}
final class GameOverEvent extends GameEvent{}
final class NewGame extends GameEvent{}
