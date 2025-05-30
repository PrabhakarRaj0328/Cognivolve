part of 'timer_bloc.dart';

sealed class TimerEvent {}

class TimerStarted extends TimerEvent {}

class Tick extends TimerEvent {
  final int timeRemaing;

  Tick(this.timeRemaing);
}