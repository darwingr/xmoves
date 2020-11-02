//import './entity.dart';
// TODO:  Both should extend entity for equality test
import 'package:meta/meta.dart'; // for @required

class BingoCard {
  static const ACTIVITY_COUNT = 25;
  final int id;
  final String title;
  // will always have special x-moves logo at E33.
  final List<BingoCardActivity> activities;

  BingoCard({
    @required this.id,
    @required this.title,
    @required this.activities,
  });
}


class BingoCardActivity {
  final int location;
  final String title;
  final String instructions;
  final String category;

  BingoCardActivity({
    @required this.location,
    @required this.title,
    @required this.instructions,
    @required this.category,
  });

  int row() { return location ~/ 10; }
  int col() { return location  % 10; }

  static int Comparator(BingoCardActivity a, BingoCardActivity b) {
    if (a.location <  b.location) return -1;
    if (a.location == b.location) return  0;
    return 1;
  }
  // optionals
  // media_description
}
