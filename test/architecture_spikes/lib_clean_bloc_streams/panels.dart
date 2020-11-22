import 'lib_clean_bloc_streams.dart';

/// To be used by the Controller/BLoC
///   to inject UseCases adapters
///   to the InputBoundary being called.
class InputPanel {
  static InputBoundary reportUseCase;
}

class OutputPanel {
  static OutputBoundary reportPresenter;
}

