import 'package:meta/meta.dart';

import 'package:xmoves/core/entity.dart';
import 'bingo_card_activity.dart';

class BingoCard extends Entity {
  static const int ACTIVITY_COUNT = 25;

  final int id;
  String title;
  List<BingoCardActivity> activities;

  BingoCard({
    @required this.id,
              this.title,
              this.activities,
  });
}
