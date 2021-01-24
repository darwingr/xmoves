import 'dart:async';

import 'package:xmoves/domain/bingo_card.dart';
import 'package:xmoves/domain/on_card_activity.dart';
import 'package:xmoves/application/on_card_activity_repository.dart';
import 'package:xmoves/infrastructure/csv_table_file.dart';

/// Headers:
///   location,
///   title,
///   instructions,
///   category
// TODO: can fail if empty csv, degenerate case
class CSVOnCardActivityRepository implements OnCardActivityRepository {
  static final String srcFilePath = "assets/data/bingo_card_activities.csv";
  final CSVTableFile csv;

  CSVOnCardActivityRepository(this.csv);

  factory CSVOnCardActivityRepository.fromAssetBundle() {
    return CSVOnCardActivityRepository(
        CSVTableFile.fromAssetBundle(srcFilePath));
  }

  Future<List<OnCardActivity>> findOnCardActivitiesForCard(BingoCard card) async
  {
    // TODO: implement findOnCardActivitiesForCard
    throw UnimplementedError();
  }

  //FIXME will break once more bingo cards are added if nothing returns
  @override
  Future<OnCardActivity> findByID(int id) async {
    assert(id > 99);
    assert(id < 99999);
    int col = id % 10;
    assert(col < 10);
    int row = (id % 100) ~/ 10;
    assert(row < 10);
    int cardID = id ~/ 100;
    assert(cardID < 1000);

    var location = ((row * 10) + col);

    final rows = await csv.rowsWhere<int>('location', (f) => f == location);

    final a = await csv.labelRow(rows.first);
    return OnCardActivity(
        bingoCardID:  a['bingo_card_id']  as int,
        location:     a['location']       as int,
        title:        a['title']          as String,
        instructions: a['instructions']   as String,
        category:     a['category']       as String
    );
  }

}
