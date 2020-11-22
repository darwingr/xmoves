import 'package:test/test.dart';

import 'lib_clean_classic.dart' as clean;

/// Architecture Spikes
///
/// 1 Classic Clean Architecture
/// 2 Dart BLoCs with Clean Architecture
///    * Handling done by BLoCs instead of "Classic Clean Controllers"
///    * BLoC Listeners: Data streams of states
///    * Futures, returned by UseCases
/// 3 Thin: Clean Architecture with fewer layers
///    - Try skipping use of Presenters, calling without passing a presenter
///    - Try using BLoCs as UseCase Interactors
/// 4 Minimal visibility from Presentation layer (BLoC), package encapsulation


/// Clean Classic
///   Full Reproduction of CleanCoders' Clean Architecture Case Study
///
/// Want to show that mutation of an object by reference can still happen to
/// an object after it's been passed to the constructor of another and the
/// original object can be read from the initial object.
void main() {
  test('ViewModel#text is accessible, mutable', () {
    var viewModel = clean.ViewModel();

    var initialText = viewModel.text;
    viewModel.text = "mutated string";

    expect(initialText,          equals("Initialized Text"));
    expect(viewModel.text, isNot(equals("Initialized Text")));
  });

  group("Presenter", () {
    group("#getViewModel()", () {
      test("can't be called before it's passed a ResponseModel "
          " by the UseCase", () {
        var presenter = clean.Presenter();
        expect(presenter.viewModel(), isNull);
      });

      /// This is bad but I want to be aware
      test("._viewModel member could be mutated after #present()", () {
        var presenter = clean.Presenter();
        var responseModel = clean.ResponseModel();
        var initialText = "Report Text";
        responseModel.reportText = initialText;

        presenter.present(responseModel);
        var altText = "Mutated Text";
        presenter.viewModel().text = altText;

        expect(presenter.viewModel().text,       equals(altText));
        expect(presenter.viewModel().text, isNot(equals(initialText)));
      });
    });
  });

  group('Controller#handle()', () {
    test("passes request data, receives output from View instance", () {
      var presenter = clean.Presenter();
      var controller = clean.Controller(
          clean.UseCase(),
          presenter,
          clean.View()
      );

      var generatedView = controller.handle();

      expect(generatedView, equals("VIEW: Report Text for useCase"));
    });
  });

  group("Thinner Clean with BLoCs", () {
  });

}
