import 'package:meta/meta.dart';
import 'package:xmoves/core/entity.dart';

class BingoCardActivity extends Entity {
  final int bingoCardID;
  int get location => _location.to_int();
  String title;
  String instructions;
  // TODO activity category should be a value object, avoid invalid category by
  //    granting a default category
  String category;

  // for sorting amongst activities on the same card
  static int locationComparator(BingoCardActivity a, BingoCardActivity b) {
    if (a.location <  b.location) return -1;
    if (a.location == b.location) return  0;
    return 1;
  }

  BingoCardActivity({
    @required this.bingoCardID,
    @required int location,
              this.title,
              this.instructions,
              this.category,
  }) : _location = OnCardLocation(location);

  int row() { return location ~/ 10; }
  int col() { return location  % 10; }

  @override
  List<Object> get identifiers => [bingoCardID, location];

  final OnCardLocation _location;
}

class OnCardLocation {
  // TODO should be RangeError.range exception and not assertions.
  const OnCardLocation(int location)
      : assert(location < 100),
        assert(location >  10),
        assert(location %  10 != 0),
        assert(location ~/ 10 != 0),
        _location = location;

  int to_int() => _location;

  final int _location;
}
