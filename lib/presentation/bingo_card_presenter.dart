import 'package:xmoves/application/bingo_card_usecase/output_boundary.dart';
import 'package:xmoves/application/bingo_card_usecase/response_model.dart';

import 'bingo_card_bloc.dart' show BingoCardViewModel, ActivityTile;

class BingoCardPresenter implements BingoCardOutputBoundary {
  //TODO set to `late` initialization once null safety is enabled
  BingoCardViewModel _viewModel;

  BingoCardViewModel getViewModel() => _viewModel;

  void present(BingoCardResponseModel responseModel) {
    _viewModel = BingoCardViewModel();
    _viewModel.title = responseModel.title;
    var activities = responseModel.getActivitySummaries();
    for (var activity in activities) {
      _viewModel.activities.add(_makeViewable(activity));
    }
  }

  ActivityTile _makeViewable(ActivitySummary activitySummary) {
    ActivityTile tile;
    if (activitySummary.category == "None") {
      tile = ActivityTile.makeFreeTile();
    } else {
      tile = ActivityTile(category: activitySummary.category);
      tile.column = activitySummary.column;
      tile.row = activitySummary.row;
    }
    return tile;
  }
}
