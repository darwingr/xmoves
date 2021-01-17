import 'response_model.dart';

abstract class BingoCardOutputBoundary {
  // NOT DECLARED ON BOUNDARY
  //BingoCardViewModel getViewModel();

  // aka `makePresentable()`
  void present(BingoCardResponseModel responseModel);
}

