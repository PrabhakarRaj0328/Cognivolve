import 'dart:math';
import 'package:logger/web.dart';

class Lottery {
  final List<int> digits;
  final int correctDigit;
  final int hiddenIndex;
  Lottery({required this.digits, required this.correctDigit, required this.hiddenIndex});
}
final logger = Logger();
List<int> ans = [4,4,4,4,4,4,4,5,5,5];
Lottery generateNewTicket() {
    Random random = Random();
    List<int> ticketNumbers = List.generate(5, (index) => random.nextInt(10));
    int correctDigit = ans[random.nextInt(10)];
    int hiddenIndex = random.nextInt(6);

    ticketNumbers.insert(hiddenIndex, correctDigit);
    return Lottery(digits: ticketNumbers, correctDigit: correctDigit, hiddenIndex: hiddenIndex);
  }