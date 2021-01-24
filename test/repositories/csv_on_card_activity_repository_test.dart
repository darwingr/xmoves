import 'package:xmoves/infrastructure/csv_bingo_card_repository.dart';
import 'package:xmoves/infrastructure/csv_on_card_activities_repository.dart';
import 'package:xmoves/infrastructure/csv_table_file.dart';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  CSVOnCardActivityRepository repo;


  setUp(() {
    repo = CSVOnCardActivityRepository.fromAssetBundle();
  });

  group('Find activity by ID', () {
    testWidgets('Card ID is 1, activity is top right', (tester) async {
      //            card  row  col
      var coding = ['001','1','5'].join();
      var id = int.parse(coding); //=> 115

      action() => repo.findByID(id);
      final activity = await tester.runAsync(action);


      expect(activity.title, equals("Push up challenge"));
    });
  });

  group('Find all activities for card', () {
  });
}
