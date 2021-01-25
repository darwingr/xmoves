import 'package:meta/meta.dart';

import 'package:xmoves/core/entity.dart';
import 'on_card_activity.dart';

class BingoCard extends Entity<int> {
  static const int ACTIVITY_COUNT = 25;

  String title;
  List<OnCardActivity> activities;

  BingoCard({
    @required int id,
              this.title,
              this.activities,
  }) : super(id: id);
}
