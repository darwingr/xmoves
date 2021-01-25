part of 'bingo_card_bloc.dart';

abstract class BingoCardEvent extends Equatable {
  const BingoCardEvent();
}

class BingoCardLoaded extends BingoCardEvent {
  @override
  List<Object> get props => [];
}
