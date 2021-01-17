import 'package:test/test.dart';

import 'package:xmoves/domain/bingo_card.dart';

void main() {
  test('two different cards have different ID numbers', () {
    var c1 = BingoCard(id: 1);
    var c2 = BingoCard(id: 2);
    expect(c1.isSame(c2), isFalse);
  });

  test('two cards that have the same ID numbers are the same Card', () {
    var c1 = BingoCard(id: 888);
    var c2 = BingoCard(id: 888);
    expect(c1.isSame(c2), isTrue);
  });
}
