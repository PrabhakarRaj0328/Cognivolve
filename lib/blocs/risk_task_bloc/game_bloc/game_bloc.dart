import 'package:cognivolve/screens/games/risk_task/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInProgress.initial()) {
    on<StartGame>((event, emit) {
      final curr = state as GameInProgress;
      final Lottery lottery = generateNewTicket();
      logger.i(lottery.correctDigit);
      emit(
        curr.copyWith(
          digits: lottery.digits,
          correctDigit: lottery.correctDigit,
          hiddenIndex: lottery.hiddenIndex,
        ),
      );
    });
    on<UserResponse>((event, emit) async { 
  GameInProgress curr = state as GameInProgress;
  
  if (event.isCorrect) {
    emit(curr.copyWith(score: curr.score + 100, isCorrect: 1));
    
    await Future.delayed(Duration(milliseconds: 300));
    
    emit(curr.copyWith(score: curr.score + 100, isCorrect: -1));
  } else {
    emit(curr.copyWith(isCorrect: 0));
    
    await Future.delayed(Duration(milliseconds: 300));
    
    emit(curr.copyWith(isCorrect: -1));
  }

  add(StartGame());
});

    on<EndGame>((event, emit) {
      if (state is GameInProgress) {
        final current = state as GameInProgress;
        emit(GameOver(current.score));
      }
    });
  }
}
