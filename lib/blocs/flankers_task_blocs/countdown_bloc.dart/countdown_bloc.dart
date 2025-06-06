import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'countdown_event.dart';
part 'countdown_state.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
  CountdownBloc() : super(CountdownInProgress(3)) {
    on<StartCountdown>((event, emit) async {
      int current = 3;
      while (current > 0 && state is CountdownInProgress) {
        await Future.delayed(const Duration(seconds: 1));
        current--;
        add(Tick(current));
      }
    });
    on<Tick>((event, emit) async {
      if (event.secondsLeft == 0) {
        emit(CountdownComplete());
      } else {
        emit(CountdownInProgress(event.secondsLeft));
      }
    });
  }
}
