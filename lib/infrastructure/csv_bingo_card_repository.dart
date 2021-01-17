import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import 'package:xmoves/domain/bingo_card.dart';
import 'package:xmoves/domain/bingo_card_activity.dart';
import 'package:xmoves/application/bingo_card_repository.dart';

class CSVBingoCardRepository implements BingoCardRepository {
  static final String srcFilePath = "assets/data/bingo_card_activities.csv";

  // TODO: can fail if empty csv, degenerate case
  Future<BingoCard> pickMostRecent() async {
    final csv = await csvData();
    var headerMap = _fieldLabels(csv);
    int cardIdColumnIdx = headerMap['bingo_card_id'];

    // 1. pick a BingoCard ID
    // TODO may fail to access
    int entryIndex = _mostRecentBingoCardOrderedByID(csv);
    final entry = csv.elementAt(entryIndex);
    final targetID = entry.elementAt(cardIdColumnIdx);
    // 2. grab the card title
    final targetTitle = csv[entryIndex][headerMap['bingo_card_title']];
    // 3. build a list of activities
    //  3.1. SELECT
    //    id, location, title (subtitle is same), instructions, category
    //  3.2. FROM
    //  3.3. WHERE
    //    'bingo_card_id' == targetID
    // BAD ORDER, row ordered data, not columnar
    var activityData = csv.where((row) => row[cardIdColumnIdx] == targetID);

    // better be only 25, not less
    List<BingoCardActivity> activities = List.from(activityData.map((a) {
      return BingoCardActivity(
          bingoCardID: targetID,
          location: a[headerMap['location']],
          title: a[headerMap['title']],
          instructions: a[headerMap['instructions']],
          category: a[headerMap['category']]);
    }), growable: false);

    activities.sort(BingoCardActivity.locationComparator);

    return BingoCard(
      id: targetID.toInt(),
      title: targetTitle,
      activities: activities,
    );
  }

  /// Infer recentness by picking the largest card ID used so far,
  /// returns the row where it is found
  _mostRecentBingoCardOrderedByID(List<List<dynamic>> csv) {
    return 1; // Row index 1 has largest bingo_card_id
  }

  _fieldLabels(List<List<dynamic>> csvData) {
    final firstRow = csvData[0];
    final idxValues = Iterable.generate(firstRow.length);
    return Map.fromIterables(firstRow, idxValues);
  }

  Future<List<List<dynamic>>> csvData() async {
    final String srcFileData = await rootBundle.loadString(srcFilePath);
    return const CsvToListConverter().convert(srcFileData);
  }
}
