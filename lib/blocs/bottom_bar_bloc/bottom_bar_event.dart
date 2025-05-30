part of 'bottom_bar_bloc.dart';

@immutable
sealed class BottomBarEvent {}

class BottomBarIndexChanged extends BottomBarEvent {
  final int index;

  BottomBarIndexChanged(this.index);
}