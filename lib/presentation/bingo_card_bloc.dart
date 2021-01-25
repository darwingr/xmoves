import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:xmoves/application/bingo_card_repository.dart';
import 'package:xmoves/application/bingo_card_usecase/input_boundary.dart';
import 'package:xmoves/application/bingo_card_usecase/interactor.dart';

import 'bingo_card_presenter.dart';

part 'bingo_card_event.dart';
part 'bingo_card_state.dart';

class BingoCardBloc extends Bloc<BingoCardEvent, BingoCardState> {
  final BingoCardPresenter _presenter;
  final BingoCardInputBoundary _useCase;

  BingoCardBloc({@required BingoCardRepository repo}) :
      _presenter = BingoCardPresenter(),
      _useCase   = BingoCardUseCaseInteractor(repo),
      super(BingoCardInitial());

  @override
  Stream<BingoCardState> mapEventToState(
    BingoCardEvent event,
  ) async* {
    if (event is BingoCardLoaded) {
      await _useCase.execute(_presenter);
      yield _presenter.getViewModel();
    }
  }
}
