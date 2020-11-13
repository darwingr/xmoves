import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:xmoves/repositories/csv_bingo_card_repository.dart';
import 'repository_panel.dart';
import 'views/bingo_card_screen.dart';
import 'theme.dart';

void main() async {
  RepositoryPanel.bingoCards = CSVBingoCardRepository();

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
                  platformPageRoute(
                      builder: (BuildContext context) => BingoCardScreen(),
                      context: context));
            },
          ),
        ),
      ),
      body: getPage(_tabIndex),
    );
  }

  Widget getPage(int tabIndex) {
    return BingoCardScreen();
  }

  _buildWithPlatformNavBar(BuildContext context) {
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
                    platformPageRoute(
                        builder: (BuildContext context) => BingoCardScreen(),
                        context: context));
              },
            ),
          ),
        ),
        body: getPage(_tabIndex),
        bottomNavBar: PlatformNavBar(
            currentIndex: _tabIndex,
            itemChanged: (index) {
              setState(() {
                _tabIndex = index;
              });
            },
            backgroundColor: Colors.blue,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.apps, color: Colors.grey),
                title: Text('Bingo', style: bottomNavTextStyle),
                activeIcon: Icon(Icons.business, color: Colors.white),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rss_feed, color: Colors.grey),
                title: Text('The Feed', style: bottomNavTextStyle),
                activeIcon: Icon(Icons.person, color: Colors.white),
              ),
            ]));
  }
}
