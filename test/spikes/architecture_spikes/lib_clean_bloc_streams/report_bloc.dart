import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'lib_clean_bloc_streams.dart';
import 'panels.dart';

/// ---CONTROLLER BOUNDARY
/// HERE FOR COMPARISON
class Controller {
  InputBoundary useCase;
  OutputBoundary presenter;
  View view;

  Controller(this.useCase, this.presenter, this.view);

  // handles requests
  String handle(RequestModel request) {
    useCase.makeReport(request, presenter);
    return view.generateView(presenter.viewModel());
  }
}

/// BLoC
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  InputBoundary useCase;
  OutputBoundary presenter;

  ReportBloc(this.useCase) : super(ReportInitial()) {
    presenter = OutputPanel.reportPresenter;
  }

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    switch (event) {
      case ReportEvent.getReport:
        InputPanel.reportUseCase.makeReport(RequestModel(), presenter);
        yield presenter.viewModel();
        break;
      case ReportEvent.getReportLazily:
        await InputPanel.reportUseCase
            .makeReportLazily(RequestModel(), presenter);
        yield presenter.viewModel();
        break;
    }
  }
}

/// EVENT
///   use OutputBoundary instead
//@immutable
//abstract class ReportEvent {}
enum ReportEvent { getReport, getReportLazily }

/// STATE
/// equivalent to ViewModel, an object built and returned by Presenter#present()
/// when passed a ResponseModel by the UseCase.
//class ReportViewModel implements ViewModel {
@immutable
class ReportState implements ViewModel {
  final String text;
  ReportState({this.text});
}

class ReportInitial extends ReportState {
  ReportInitial() : super(text: "Initialized State Text");
}

/// implements OutputBoundary
class Presenter implements OutputBoundary {
  ReportState _viewModel;

  // This is the call we need to wait on,
  // ONLY IF it guarantees present() was run every time before.
  // THEREFORE await on the UseCase to complete instead.
  ReportState viewModel() {
    return _viewModel;
  }

  void present(ResponseModel responseModel) {
    _viewModel = ReportState(text: responseModel.reportText);
  }
}

/// ---VIEW BOUNDARY
/// HERE FOR COMPARISON
class View {
  String generateView(ReportState viewModel) {
    return "VIEW: ${viewModel.text}";
  }
}
