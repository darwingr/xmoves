import 'package:meta/meta.dart';

import 'package:xmoves/core/entity.dart';
import 'on_card_activity.dart';

class BingoCard extends Entity {
  static const int ACTIVITY_COUNT = 25;

  final int id;
  String title;
  List<OnCardActivity> activities;

  BingoCard({
    @required this.id,
              this.title,
              this.activities,
  });
}
