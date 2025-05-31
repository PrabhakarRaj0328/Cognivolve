part of 'phase_bloc.dart';

@immutable
sealed class PhaseEvent {}
final class PhaseChange extends PhaseEvent{
  final Map<String,String> currentImagePair;
  PhaseChange(this.currentImagePair);
}
