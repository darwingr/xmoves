import 'package:meta/meta.dart'; // for @required

import 'entity.dart';

class BingoCardActivity extends Entity {
  final int bingoCardID;
  final int location;
  String title;
  String instructions;
  String category;

  BingoCardActivity({
    @required this.bingoCardID,
    @required this.location,
              this.title,
              this.instructions,
              this.category,
  });

  @override
  List<Object> get identifiers => [bingoCardID, location];

  int row() { return location ~/ 10; }
  int col() { return location  % 10; }

  // for sorting amongst activities on the same card
  // TODO: should be under test?
  static int comparator(BingoCardActivity a, BingoCardActivity b) {
    if (a.location <  b.location) return -1;
    if (a.location == b.location) return  0;
    return 1;
  }
}
