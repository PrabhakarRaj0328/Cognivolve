import 'package:cognivolve/blocs/corsi_span_task/game_bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CorsiTrialData {
  final int trialNumber;
  final List<int> target;
  final bool isReversed;
  final List<int> userResponse;
  final bool isCorrect;
  final int reactionTime;
  final int sequenceLength;
  final DateTime timestamp;

  CorsiTrialData({
    required this.trialNumber,
    required this.target,
    required this.isReversed,
    required this.userResponse,
    required this.isCorrect,
    required this.reactionTime,
    required this.sequenceLength,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'trialNumber': trialNumber,
    'highlightedIndex': target,
    'Reversed': isReversed,
    'userResponse': userResponse,
    'isCorrect': isCorrect,
    'reactionTime': reactionTime,
    'sequenceLength': sequenceLength,
    'timestamp': timestamp.toIso8601String(),
  };
}

Widget buildGrid(int gridSize, int highlightedIndex,Color cueColor) {
  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    itemCount: 9,
    itemBuilder: (context, index) {
      bool isHighlighted = index == highlightedIndex;
      return GestureDetector(
        onTap: (){
          context.read<GameBloc>().add(BlockTapped(index));
        },
        child: Container(
        margin: EdgeInsets.all(2),
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
