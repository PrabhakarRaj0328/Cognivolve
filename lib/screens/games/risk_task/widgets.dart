import 'package:flutter/material.dart';

class LotteryTicket extends StatelessWidget {
  final List<int> numbers;
  final int hiddenIndex;

  const LotteryTicket({
    super.key,
    required this.numbers,
    required this.hiddenIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LOTTERY TICKET',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Icon(Icons.confirmation_number),
              ],
            ),
          ),

          // Numbers Display
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  numbers.asMap().entries.map((entry) {
                    int index = entry.key;
                    int number = entry.value;
                    bool isHidden = index == hiddenIndex;

                    return Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isHidden ? Colors.grey[300] : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isHidden ? Colors.orange : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          isHidden ? '?' : number.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isHidden ? Colors.orange : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          // Instructions
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Guess the hidden digit!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceButtons extends StatelessWidget {
  final int digit1;
  final int digit2;
  final Function(int) onChoice;

  const ChoiceButtons({
    super.key,
    required this.digit1,
    required this.digit2,
    required this.onChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildChoiceButton(digit1, Colors.green),
        _buildChoiceButton(digit2, Colors.orange),
      ],
    );
  }

  Widget _buildChoiceButton(int digit, Color color) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => onChoice(digit),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            digit.toString(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
class RiskTrialData {
  final int trialNumber;
  final List<int> digits;
  final int hiddenIndex;
  final int correctDigit;
  final int userResponse;
  final bool isCorrect;
  final int reactionTime;
  final DateTime timestamp;

  RiskTrialData({
    required this.trialNumber,
    required this.digits,
    required this.hiddenIndex,
    required this.correctDigit,
    required this.userResponse,
    required this.isCorrect,
    required this.reactionTime,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'trialNumber': trialNumber,
    'digits': digits,
    'hiddenIndex': hiddenIndex,
    'correctDigit': correctDigit,
    'userResponse': userResponse,
    'isCorrect': isCorrect,
    'reactionTime': reactionTime,
    'timestamp': timestamp.toIso8601String(),
  };
}
