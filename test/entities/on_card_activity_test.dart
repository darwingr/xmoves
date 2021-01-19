import 'package:test/test.dart';

import 'package:xmoves/domain/on_card_activity.dart';
import 'package:xmoves/domain/activity_progress.dart';

final Matcher throwsAssertionError = throwsA(isA<AssertionError>());

void main() {
  group('two different activities', () {
    test('on different cards are not the same', () {
      var a1 = OnCardActivity(bingoCardID: 1, location: 55);
      var a2 = OnCardActivity(bingoCardID: 2, location: 55);
      expect(a2.isSame(a1), isFalse);
    });

    test('on the same card are not the same', () {
      var a1 = OnCardActivity(bingoCardID: 3, location: 44);
      var a2 = OnCardActivity(bingoCardID: 3, location: 22);
      expect(a2.isSame(a1), isFalse);
    });
  });

  group('Valid Construction', () {
    test('default constructed ActivityProgress unless specified', () {
      var bca = OnCardActivity(bingoCardID: 1, location: 12);
      expect(bca.status(), equals(ActivityProgress.initialStatus));
    });

    test('location parameter accepts an int', () {
    });

    test('location parameter must have 2 digits exactly', () {
      // TODO should be RangeError.range exception and not assertions.
      //throwsRangeError
      expect(
          () => OnCardActivity(bingoCardID: 1, location: 123),
          throwsAssertionError
      );
      expect(
          () => OnCardActivity(bingoCardID: 1, location: 1),
          throwsAssertionError
      );
    });

    test('location parameter has no zeros', () {
      expect(
          () => OnCardActivity(bingoCardID: 1, location: 10),
          throwsAssertionError
      );
    });
  });

  group('Two dimensional positioning', () {
    group('row()', () {
    });

    group('col()', () {
    });
  });

  group('locationComparator(a, b)', () {
  });
}
