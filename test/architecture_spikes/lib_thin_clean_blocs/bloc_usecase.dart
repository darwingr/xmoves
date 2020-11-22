import 'package:meta/meta.dart';

@immutable
abstract class ViewModel {}

// ---PRESENTATION BOUNDARY

// ---DOMAIN BOUNDARY

/// Implemented by UseCases
///      called by Controllers
abstract class InputBoundary {
  void makeReport(RequestModel requestModel, OutputBoundary presenter);
  Future<void> makeReportLazily(
      RequestModel requestModel, OutputBoundary presenter);
}

class RequestModel {}

/// Implemented by Presenters
///      called by UseCases
abstract class OutputBoundary {
  ViewModel viewModel();
  void present(ResponseModel responseModel);
}

class ResponseModel {
  String reportText;
}

/// Implements InputBoundary
class UseCase implements InputBoundary {
  void makeReport(RequestModel requestModel, OutputBoundary presenter) {
    var repo = _Repository();
    var reportFromEntity = repo.getEntity();
    ResponseModel responseModel = ResponseModel();
    responseModel.reportText = reportFromEntity;
    presenter.present(responseModel);
  }

  // MAY  return void, "fire and forget".
  // MUST return Future<void> to force calling code to 'await' for it to finish.
  // SHOULD return Future<void> on UseCase until it can be done properly
  //        on Presenter#viewModel().
  Future<void> makeReportLazily(
      RequestModel requestModel, OutputBoundary presenter) async {
    var repo = _LazyRepository();
    var reportFromEntity = repo.getEntity();
    ResponseModel responseModel = ResponseModel();
    responseModel.reportText = await reportFromEntity;
    presenter.present(responseModel);
  }
}

class _Repository {
  String _reportEntity = "Report Text for useCase";

  String getEntity() {
    return this._reportEntity;
  }
}

class _LazyRepository {
  String _reportEntity = "Report Text from Lazy Repository";

  Future<String> getEntity() async {
    return this._reportEntity;
  }
}
