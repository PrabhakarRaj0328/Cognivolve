part of 'phase_bloc.dart';

@immutable
sealed class PhaseState {}

final class CurrentPhase extends PhaseState {
  final Map<String,String> currentImagePair;
  CurrentPhase(this.currentImagePair);
}

