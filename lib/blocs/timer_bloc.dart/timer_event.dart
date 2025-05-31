part of 'timer_bloc.dart';

sealed class TimerEvent {}

class TimerStart extends TimerEvent {
  final int duration;
  TimerStart(this.duration);
}

class Tick extends TimerEvent {
  final int timeRemaining;

  Tick(this.timeRemaining);
}
class PauseTimer extends TimerEvent {}
class ResumeTimer extends TimerEvent {}