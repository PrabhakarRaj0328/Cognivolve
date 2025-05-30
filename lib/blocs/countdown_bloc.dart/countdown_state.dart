part of 'countdown_bloc.dart';

sealed class CountdownState {}

final class CountdownInProgress extends CountdownState {
  final int secondsRemaining;
  CountdownInProgress(this.secondsRemaining);
}

final class CountdownComplete extends CountdownState {}
