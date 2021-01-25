import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:xmoves/infrastructure/csv_bingo_card_repository.dart';
import 'package:xmoves/application/repository_adapters.dart';
import 'package:xmoves/presentation/bingo_card_bloc.dart';

import 'view/bingo_card_screen.dart';
import 'view/play_card_view.dart';
import 'view/widgets/message_display_widget.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // before accessing rootBundle
  RepositoryAdapters.bingoCards = CSVBingoCardRepository.fromAssetBundle();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      debugShowCheckedModeBanner: false,
      material: (_, __) => MaterialAppData(theme: materialThemeData),
      cupertino: (_, __) => CupertinoAppData(theme: cupertinoTheme),
      title: 'X-Moves',
      home: MyHomePage(title: 'X-Moves'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return PlatformScaffold(
      appBar: PlatformAppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: toolbarTextStyle),
        cupertino: (_, __) => CupertinoNavigationBarData(
          transitionBetweenRoutes: false,
          trailing: PlatformButton(
            padding: EdgeInsets.all(4.0),
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  platformPageRoute<Widget>(
                      builder: (context) => BingoCardScreen(),
                      context: context));
            },
          ),
        ),
      ),
      body: getPage(_tabIndex),
      bottomNavBar: PlatformNavBar(
          currentIndex:
            _tabIndex,
            itemChanged: (index) => setState(() => _tabIndex = index ),
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              label: 'Bingo (Old)',
              icon:       Icon(Icons.apps, color: Colors.grey),
              activeIcon: Icon(Icons.apps, color: Colors.blue),
            ),
            BottomNavigationBarItem(
              label: 'The Feed',
              icon:       Icon(Icons.rss_feed, color: Colors.grey),
              activeIcon: Icon(Icons.rss_feed, color: Colors.blue),
            ),
            BottomNavigationBarItem(
              label: 'Bingo',
              icon:       Icon(Icons.apps, color: Colors.grey),
              activeIcon: Icon(Icons.apps, color: Colors.blue),
            ),
          ]));
  }

  Widget getPage(int tabIndex) {
    switch (tabIndex) {
      case (0):
        return BingoCardScreen();
      case (1):
        return MessageDisplay(message: "Placeholder For Blog Feed");
      case (2):
        return BlocProvider(
            create: (context) =>
                BingoCardBloc(repo: RepositoryAdapters.bingoCards)
                  ..add(BingoCardLoaded()),
            child: PlayCardView(),
        );
      default:
        return MessageDisplay(
            message: "Navigation Index Error: No Widget Configured");
    }
  }
}
