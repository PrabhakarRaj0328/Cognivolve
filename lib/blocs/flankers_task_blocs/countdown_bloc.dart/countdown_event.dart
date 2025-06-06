part of 'countdown_bloc.dart';

sealed class CountdownEvent {}

class StartCountdown extends CountdownEvent {
}

class Tick extends CountdownEvent {
  final int secondsLeft;

  Tick(this.secondsLeft);
}
