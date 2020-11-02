import 'package:meta/meta.dart';

import 'entity.dart';
import 'bingo_card_activity.dart';

class BingoCard extends Entity {
  static const ACTIVITY_COUNT = 25;

  final int id;
  String title;
  List<BingoCardActivity> activities;

  BingoCard({
    @required this.id,
              this.title,
              this.activities,
  });
}
