import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInProgress(45)) {
    on<TimerStarted>((event, emit) async {
      int current = 45;
      while (current >= 0 && state is TimerInProgress) {
        await Future.delayed(const Duration(seconds: 1));
        current--;
        if (!isClosed) {
          add(Tick(current));
        }
      }
    });
    on<Tick>((event, emit) async {
      if (event.timeRemaing <= 0) {
        emit(TimerEnded());
      } else {
        emit(TimerInProgress(event.timeRemaing));
      }
    });
  }
}
