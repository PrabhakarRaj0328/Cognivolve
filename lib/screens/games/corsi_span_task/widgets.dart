import 'package:cognivolve/blocs/corsi_span_task/game_bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildGrid(int gridSize, int highlightedIndex,Color cueColor) {
  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: gridSize,
    ),
    itemCount: gridSize * gridSize,
    itemBuilder: (context, index) {
      bool isHighlighted = index == highlightedIndex;
      return GestureDetector(
        onTap: (){
          context.read<GameBloc>().add(BlockTapped(index));
        },
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isHighlighted ?  cueColor: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
        ),
      );
    },
  );
}
