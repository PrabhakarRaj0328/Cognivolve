import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'countdown_event.dart';
part 'countdown_state.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
    StreamSubscription<int>? _tickerSubscription;
  CountdownBloc() : super(CountdownInProgress(3)) {
    on<StartCountdown>((event, emit) async {

    _tickerSubscription?.cancel(); 
    final duration = 3;
      
    _tickerSubscription = Stream.periodic(Duration(seconds: 1), (x) => duration - x - 1)
        .takeWhile((t) => t >= 0&&state is CountdownInProgress)
        .listen((timeRemaining) {
          
      add(Tick(timeRemaining));
    });
    emit(CountdownInProgress(duration));
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
