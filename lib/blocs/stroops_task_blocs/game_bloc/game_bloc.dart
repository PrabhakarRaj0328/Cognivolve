import 'package:cognivolve/screens/games/stroops_task/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
    : super(GameInProgress('black', 'yellow', 0, false, 'black', 'black')) {
    on<StartGame>((event, emit) {
      List<String> gameColors = randomColors();
      final ans = gameColors[1] == gameColors[2];
      emit(
        GameInProgress(
          gameColors[1],
          gameColors[3],
          0,
          ans,
          gameColors[0],
          gameColors[2],
        ),
      );
    });

    on<UserResponse>((event, emit) {
      if (state is GameInProgress) {
        final current = state as GameInProgress;
          final List<String> gameColors = randomColors();
          int score =  current.score;
          final ans = gameColors[1] == gameColors[2];
          if(event.isCorrect) {
            score += 100;
          }
          emit(
            GameInProgress(
              gameColors[1],
              gameColors[3],
              score,
              ans,
              gameColors[0],
              gameColors[2],
            ),
          );
        
      }
    });
    on<EndGame>((event, emit) {
      if (state is GameInProgress) {
        final current = state as GameInProgress;
        emit(GameOver(current.score));
      }
    });
  }
}
