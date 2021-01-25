part of 'bingo_card_bloc.dart';

/// The VIEW_MODEL for bingo card details thus only includes
abstract class BingoCardState extends Equatable {
  const BingoCardState();
}

class BingoCardInitial extends BingoCardState {
  @override
  List<Object> get props => [];
}

class ActivityTile {
  bool isClickable;
  String category;
  int column;
  int row;

  ActivityTile({this.category}) :
      isClickable = true;

  factory ActivityTile.makeFreeTile() {
    var tile = ActivityTile(category: "FREE TILE");
    tile.isClickable = false;
    return tile;
  }
}


class BingoCardViewModel extends BingoCardState {
  String title;
  List< ActivityTile> activities;

  BingoCardViewModel() :
    activities = [];

  @override
  List<Object> get props => [title];
}
