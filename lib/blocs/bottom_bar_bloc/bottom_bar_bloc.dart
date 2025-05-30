import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState>{
  BottomBarBloc() : super(BottomBarState(0)) {
    on<BottomBarIndexChanged>((event, emit) {
      emit(BottomBarState(event.index));
    });
  }
}