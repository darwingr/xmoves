import 'package:flutter_test/flutter_test.dart';
import 'package:xmoves/domain/bingo_card.dart';
import 'package:xmoves/infrastructure/csv_bingo_card_repository.dart';

void main() async {
  CSVBingoCardRepository repo;

  setUp(() {
    repo = CSVBingoCardRepository.fromAssetBundle();
  });

  group('Find by ID', () {

    testWidgets('Card ID is 1', (tester) async {
      action() => repo.findByID(1);
      final card = await tester.runAsync(action);

      expect(card.id, 1);
    });


    //TODO failure case handling for repositories
    testWidgets('ID not in repository', (tester) async {
      action() => repo.findByID(0);
      final card = await tester.runAsync(action);

      expect(card.id, 1);
    }, skip: true);
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
