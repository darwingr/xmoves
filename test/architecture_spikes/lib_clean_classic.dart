class ViewModel {
  String text = "Initialized Text";
}

class View {
  String generateView(ViewModel viewModel) {
    return "VIEW: ${viewModel.text}";
  }
}

//---

class ResponseModel {
  String reportText;
}

/// Implements InputBoundary
class UseCase {
  String reportFromEntity = "Report Text for useCase";

  void makeReport(Presenter presenter) {
    ResponseModel responseModel = ResponseModel();
    responseModel.reportText = this.reportFromEntity;
    presenter.present(responseModel);
  }
}

/// implements OutputBoundary
class Presenter {
  ViewModel _viewModel;

  ViewModel viewModel() {
    return _viewModel;
  }

  void present(ResponseModel responseModel) {
    _viewModel = ViewModel();
    _viewModel.text = responseModel.reportText;
  }
}

class Controller {
  UseCase useCase;
  Presenter presenter;
  View view;

  Controller(this.useCase, this.presenter, this.view);

  // handles requests
  String handle() {
    useCase.makeReport(presenter);
    return view.generateView(presenter.viewModel());
  }
}

