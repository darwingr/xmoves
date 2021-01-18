import 'package:flutter_test/flutter_test.dart';
import 'package:xmoves/infrastructure/csv_bingo_card_repository.dart';

void main() async {
  CSVBingoCardRepository repo;

  setUp(() {
    repo = CSVBingoCardRepository();
  });

  tearDown(() {
    repo = null;
  });

  group('CSV starts with a header row', () {
    action() => repo.csvData();

    testWidgets('of a fixed size', (tester) async {
      final csv = await tester.runAsync(action);

      final headers = csv[0];
      expect(headers.length, 9);
    });
  });

  group('Pick most recent Bingo Card from CSV', () {
    action() => repo.pickMostRecent();

    testWidgets('Card ID is 1', (tester) async {
      final card = await tester.runAsync(action);

      expect(card.id, 1);
    });

    testWidgets('First and last activities have locations 11 and 55',
            (tester) async
    {
      final card = await tester.runAsync(action);
      var firstActivity = card.activities.first;
      var lastActivity  = card.activities.last;

      expect(firstActivity.location, 11);
      expect(lastActivity.location,  55);
    });
  });
}
