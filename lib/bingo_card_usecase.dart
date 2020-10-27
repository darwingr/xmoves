import 'dart:async';
import 'package:dartz/dartz.dart';

import 'failures.dart';
import 'bingo_card.dart';
import 'repositories/bingo_card_repository.dart';


class BingoCardUseCase {

  // TODO don't pass entity to presentation layer
  // TODO strip quotes chars from text on Activity.instructions
  //Future<Either<Failure, BingoCard>> playWithLatestBingoCard() async {
  Future<BingoCard> playWithLatestBingoCard() async {
    var repo = BingoCardRepository();
    return repo.pickAny();
  }
}

