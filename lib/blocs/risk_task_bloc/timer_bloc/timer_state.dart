part of 'timer_bloc.dart';

sealed class TimerState {}

final class TimerInProgress extends TimerState{
final int timeRemaing;
TimerInProgress(this.timeRemaing);
}
final class TimerEnded extends TimerState {}
final class TimerPaused extends TimerState {
  final int timeRemaing;
  TimerPaused(this.timeRemaing);
}
