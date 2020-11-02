import 'package:flutter_test/flutter_test.dart';

import 'package:xmoves/csv_bingo_card_repository.dart';

void main() {
  //testWidgets('Printed out looks like ', (WidgetTester tester) async {
  //  var repo = BingoCardRepository();
  //  var f = repo.csvData();
  //  var headers = await f.then( (ll) => ll[0]);
  //  for (var h in headers) {
  //    print(h);
  //  }
  //});

  // TODO should not require 'testWidget' to run unit test against repo
  testWidgets('Pick any Bingo Card from CSV ', (WidgetTester tester) async {
    var repo = CSVBingoCardRepository();

    var f = repo.csvData();
    var headers = await f.then( (ll) => ll[0]);

    var card = await repo.pickAny();
    var cardActivities = card.activities;
    for (var activity in cardActivities) {
      print("${activity.location}: ${activity.title}");
    }
  });
}
