import 'dart:async';
import 'package:dartz/dartz.dart';

import 'package:xmoves/core/failures.dart';
import 'package:xmoves/entities/bingo_card.dart';
import 'package:xmoves/usecases/repository_panel.dart';

/// Input to be provided by the user,
///   card_id
/// Output to be returned to the user and
///   card_name,
///   card_description
///   activity_matrix(activity_id, category, status),
/// Processing steps involved in producing that output.
class BingoCardUseCase {
  // TODO don't pass entity to presentation layer
  // TODO strip quotes chars from text on Activity.instructions
  //Future<Either<Failure, BingoCard>> playWithLatestBingoCard() async {
  Future<BingoCard> playWithLatestBingoCard() async {
    return RepositoryPanel.bingoCards.pickMostRecent();
  }
}
