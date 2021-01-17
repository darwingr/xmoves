import 'package:test/test.dart';

import 'lib_clean_bloc_streams/lib_clean_bloc_streams.dart' as domain;
import 'lib_clean_bloc_streams/report_bloc.dart' as presentation;
import 'lib_clean_bloc_streams/panels.dart';

Future<void> main() async {
  presentation.ReportBloc bloc;

  setUpAll(() {
    InputPanel.reportUseCase = domain.UseCase();
    OutputPanel.reportPresenter = presentation.Presenter();
  });

  setUp(() {
    bloc = presentation.ReportBloc(InputPanel.reportUseCase);
  });

  tearDown(() async {
    await bloc.close();
  });

  group('UseCase#makeReport', () {
    test("Basic Usage, like Cubit, will return a ViewModel", () async {
      var initialText = presentation.ReportInitial().text;

      bloc.add(presentation.ReportEvent.getReport);
      // To ensure we wait for the next event-loop iteration,
      // allowing the event to be processed.
      await Future<dynamic>.delayed(Duration.zero);

      expect(bloc.state,      isA<domain.ViewModel>());
      expect(bloc.state,      isA<presentation.ReportState>());
      expect(bloc.state.text, isNot(equals(initialText)));
    });

    test("Stream Usage, as a BLoC, changes state 3 times", () async {
      int i = 0;
      var increment = (presentation.ReportState state) => ++i;
      // calls print on each state change
      final subscription = bloc.listen(increment);
      bloc.add(presentation.ReportEvent.getReport);
      bloc.add(presentation.ReportEvent.getReport);
      bloc.add(presentation.ReportEvent.getReport);
      // to avoid cancelling sub immediately
      await Future<dynamic>.delayed(Duration.zero);

      expect(i, equals(3));
      await subscription.cancel();
    });
  });

  group('UseCase#makeReportLazily', () {
    test("BLoC returns a Report data from Repository of Futures", () async {
      var initialText = presentation.ReportInitial().text;

      bloc.add(presentation.ReportEvent.getReportLazily);
      await Future<dynamic>.delayed(Duration.zero);

      expect(bloc.state,      isA<domain.ViewModel>());
      expect(bloc.state,      isA<presentation.ReportState>());
      expect(bloc.state.text, isNot(equals(initialText)));
    });

    test("Stream & Listener Usage, changes state 3 times", () async {
      int i = 0;
      var increment = (presentation.ReportState state) => ++i;
      final subscription = bloc.listen(increment);

      bloc.add(presentation.ReportEvent.getReportLazily);
      bloc.add(presentation.ReportEvent.getReportLazily);
      bloc.add(presentation.ReportEvent.getReportLazily);
      await Future<dynamic>.delayed(Duration.zero);

      expect(i, equals(3));
      await subscription.cancel();
    });
  });
}
