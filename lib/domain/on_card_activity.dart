import 'package:meta/meta.dart';
import 'package:xmoves/core/entity.dart';

import 'activity_progress.dart';

class OnCardActivity extends Entity {
  final int bingoCardID;
  //TODO change to storing row/column instead of location
  int get location => _location.toInt();
  String title;
  String instructions;
  // TODO activity category should be a value object, avoid invalid category by
  //    granting a default category
  String category;

  // for sorting amongst activities on the same card
  static int locationComparator(OnCardActivity a, OnCardActivity b) {
    if (a.location <  b.location) return -1;
    if (a.location == b.location) return  0;
    return 1;
  }

  OnCardActivity({
    @required this.bingoCardID,
    @required int location,
              this.title,
              this.instructions,
              this.category,
    ActivityProgress progress,
  }) : _location = OnCardLocation(location),
       _progress = progress ?? ActivityProgress(bingoCardID: bingoCardID,
                                                activityID: location);

  int row() { return location ~/ 10; }
  int col() { return location  % 10; }

  ActivityProgressStatus status() => _progress.status;

  @override
  List<Object> get identifiers => [bingoCardID, location];

  final OnCardLocation _location;
  ActivityProgress _progress;
}

class OnCardLocation {
  // TODO should be RangeError.range exception and not assertions.
  const OnCardLocation(int location)
      : assert(location < 100),
        assert(location >  10),
        assert(location %  10 != 0),
        assert(location ~/ 10 != 0),
        _location = location;

  int toInt() => _location;

  final int _location;
}
