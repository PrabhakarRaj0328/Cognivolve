import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  StreamSubscription<int>? _tickerSubscription;
  TimerBloc() : super(TimerInProgress(30)) {
    on<TimerStart>((event, emit) async {

    _tickerSubscription?.cancel(); 
    final duration = event.duration;

    _tickerSubscription = Stream.periodic(Duration(seconds: 1), (x) => duration - x - 1)
        .takeWhile((t) => t >= 0&&state is TimerInProgress)
        .listen((timeRemaining) {
          
      add(Tick(timeRemaining));
    });
    emit(TimerInProgress(duration));
    });

    on<Tick>((event, emit) async {
      if (event.timeRemaining <= 0) {
        emit(TimerEnded());
      } else {
        emit(TimerInProgress(event.timeRemaining));
      }
    });
    on<PauseTimer>((event, emit){
      final currentState = state as TimerInProgress;
      emit(TimerPaused(currentState.timeRemaing));
    });
    on<ResumeTimer>((event, emit){
      final currentState = state as TimerPaused;
      add(TimerStart(currentState.timeRemaing));
    });
  }
 @override
Future<void> close() {
  if (kDebugMode) {
    print('[DEBUG] TimerBloc closed');
  }
  return super.close();
}
}
