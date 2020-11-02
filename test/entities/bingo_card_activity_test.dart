import 'package:test/test.dart';

import 'package:xmoves/entities/bingo_card_activity.dart';

void main() {
  group('two different activities', () {
    test('on different cards are not the same', () {
      var a1 = BingoCardActivity(bingoCardID: 1, location: 55);
      var a2 = BingoCardActivity(bingoCardID: 2, location: 55);
      expect(a2.isSame(a1), isFalse);
    });

    test('on the same card are not the same', () {
      var a1 = BingoCardActivity(bingoCardID: 3, location: 44);
      var a2 = BingoCardActivity(bingoCardID: 3, location: 22);
      expect(a2.isSame(a1), isFalse);
    });
  });
}
