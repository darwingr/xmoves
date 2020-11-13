import 'package:xmoves/entities/bingo_card_activity.dart';
import 'package:xmoves/entities/bingo_card.dart';
import 'package:xmoves/usecases/repository_panel.dart';

class User {
}

class ResponseModel {
  var bingoCardID;
  String title;
}

/// Output to be returned to the user and
///   card_name,
///   card_description
///   activity_matrix(activity_id, category, status),
/// This is a block state
class ViewModel {
}

/// Interface to be implemented by BLoC?
abstract class BingoCardOutputBoundary {
  ViewModel getViewModel();
  void present(ResponseModel responseModel);
}

/// Input Data:
///   card_id
abstract class BingoCardInputBoundary {
  void getBingoCardProgress(
      String cardID,
      BingoCardOutputBoundary presenter);

  void getLatestBingoCardProgress(
      BingoCardOutputBoundary presenter);
}


/// The Interactor
///   implements the InputBoundary
///   as a Usecase
class BingoCardUseCase implements BingoCardInputBoundary {
  @override
  void getBingoCardProgress(
      String cardID,
      BingoCardOutputBoundary presenter)
  {
    ResponseModel responseModel = ResponseModel();
    BingoCard currentCard = RepositoryPanel.bingoCards.pickMostRecent();

    //for (Codecast codecast : allCodecasts)
    //  responseModel.addCodecastSummary(summarizeCodecast(codecast, loggedInUser));

    presenter.present(responseModel);
  }

  @override
  void getLatestBingoCardProgress(BingoCardOutputBoundary presenter) {
    // TODO: implement getLatestBingoCardProgress
  }
}
