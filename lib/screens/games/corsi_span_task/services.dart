import 'dart:math';

List<int> generateSequence(int length, int maxIndex) {
  Random rand = Random();
  Set<int> seen = {};
  while (seen.length < length) {
    seen.add(rand.nextInt(maxIndex));
  }
  return seen.toList();
}

bool compareLists(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
}