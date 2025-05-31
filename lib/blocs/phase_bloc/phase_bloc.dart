import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'phase_event.dart';
part 'phase_state.dart';

class PhaseBloc extends Bloc<PhaseEvent, PhaseState> {
  PhaseBloc() : super(CurrentPhase({'null': 'null'})) {
    on<PhaseChange>((event, emit) {
       emit(CurrentPhase(event.currentImagePair));
    });
  }
}
