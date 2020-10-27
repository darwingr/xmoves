import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import './bingo_card_screen.dart';

// Theme Data (hex format, precede with 0xff)
// Dark Blue:   0xff3A5067
final dark_blue = const Color(0xff3A5067);
// Light Blue:  0xff4D6275
final light_blue = const Color(0xff4D6275);

final materialThemeData = ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primarySwatch: Colors.blue,
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.blue,
    appBarTheme: AppBarTheme(color: Colors.blue.shade600),
    primaryColor: Colors.blue,
    secondaryHeaderColor: Colors.blue,
    canvasColor: Colors.blue,
    backgroundColor: Colors.red,
    textTheme: TextTheme().copyWith(body1: TextTheme().body1));

final cupertinoTheme = CupertinoThemeData(
    primaryColor: light_blue,
    barBackgroundColor: Colors.white,
    scaffoldBackgroundColor: light_blue);

// Styles
final bottomNavTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
final toolbarButtonTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
final toolbarTextStyle = TextStyle(color: Colors.black, fontSize: 16.0);

void main() => runApp(MyApp());

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
  int _counter = 0;
  int _tabIndex = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
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
