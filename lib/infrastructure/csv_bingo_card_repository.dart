import 'dart:async';

import 'package:xmoves/domain/bingo_card.dart';
import 'package:xmoves/domain/on_card_activity.dart';
import 'package:xmoves/application/bingo_card_repository.dart';
import 'package:xmoves/infrastructure/csv_table_file.dart';


// TODO: can fail if empty csv, degenerate case
class CSVBingoCardRepository implements BingoCardRepository {
  static final String srcFilePath = "assets/data/bingo_card_activities.csv";
  final CSVTableFile csv;

  CSVBingoCardRepository(this.csv);

  // Want to avoid the path details in the presentation layer
  factory CSVBingoCardRepository.fromAssetBundle() {
    return CSVBingoCardRepository(CSVTableFile.fromAssetBundle(srcFilePath));
  }

  Future<BingoCard> pickMostRecent() async {
    var cardID = _mostRecentBingoCardOrderedByID();
    return findByID(cardID);
  }

  Future<BingoCard> findByID(int cardID) async {
    // 1. Get BingoCard ID
    final rows = await csv.rowsWhere<int>('bingo_card_id', (f) => f==cardID);
    final row = await csv.labelRow(rows.first);
    final targetID = row['bingo_card_id'] as int;
    // 2. grab the card title
    final targetTitle = row['bingo_card_title'] as String;
    // 3. build a list of activities
    final activities = await _fetchActivityList(rows);
    activities.sort(OnCardActivity.locationComparator);

    return BingoCard(
      id: targetID.toInt(),
      title: targetTitle,
      activities: activities,
    );
  }

  Future<List<OnCardActivity>> _fetchActivityList(List<List> filteredRows)
    async
  {
    var activities = <OnCardActivity>[];
    for (var row in filteredRows) {
      final record = await csv.labelRow(row);
      activities.add(_fetchActivity(record));
    }
    return activities;
  }

  OnCardActivity _fetchActivity(Map<String, dynamic> record) =>
    OnCardActivity(
      bingoCardID:  record['bingo_card_id']  as int,
      location:     record['location']       as int,
      title:        record['title']          as String,
      instructions: record['instructions']   as String,
      category:     record['category']       as String
    );

  /// Infer recentness by picking the largest card ID used so far,
  /// returns the row where it is found
  int _mostRecentBingoCardOrderedByID() {
    return 1; // just a dummy
  }
}
