import 'dart:async';

import 'package:xmoves/application/bingo_card_repository.dart';
import 'package:xmoves/domain/bingo_card.dart';

import 'output_boundary.dart';
import 'response_model.dart';

abstract class BingoCardInputBoundary {
  BingoCardInputBoundary(BingoCardRepository repository);
  Future<void> execute(BingoCardOutputBoundary presenter);
}

/// Input to be provided by the user,
///   card_id
/// Output to be returned to the user and
///   card_name,
///   card_description
///   activity_matrix(activity_id, category, status),
/// Processing steps involved in producing that output.
class BingoCardUseCaseInteractor implements BingoCardInputBoundary  {
  final BingoCardRepository _repository;

  BingoCardUseCaseInteractor(this._repository);

  // TODO don't pass entity to presentation layer
  // TODO strip quotes chars from text on Activity.instructions
  @deprecated
  Future<BingoCard> playWithLatestBingoCard() async {
    return _repository.pickMostRecent();
  }

  //TODO should return Future of Success/Failure so the caller knows to not ask
  // the Presenter for its ViewModel.
  Future<void> execute(BingoCardOutputBoundary presenter) async {
    // 1. Get BingoCard that is latest issue
    // 2. Get a List of all activities for the given BingoCard
    var card = await _repository.pickMostRecent();
    var response = BingoCardResponseModel(card.title);
    for (var activity in card.activities) {
      var activitySummary = ActivitySummary();
      activitySummary.category = activity.category;
      activitySummary.column = activity.col();
      activitySummary.row    = activity.row();
      response.addActivitySummary(activitySummary);
    }

    presenter.present(response);
  }
}
