import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'bingo_card_usecase.dart';
//TODO NO entities in view layer
import 'bingo_card.dart';
import 'activity_details_screen.dart';

class Item {
  int id;
  String title;
  String subtitle;
  String event = "Incomplete";
  String img;
  //Item({this.title, this.subtitle, this.event, this.img});
  Item(var title) :
    this.id = 0,
    this.title = title,
    this.subtitle = title,
    this.event = "Incomplete",
    this.img = "images/AppIcon-128.png";

  String location() {
    return "row ${this.id ~/ 10}, column ${this.id % 10}";
  }
}

// Theme Data (hex format, precede with 0xff)
// Dark Blue:   0xff3A5067
var dark_blue = const Color(0xff3A5067);
// Light Blue:  0xff4D6275
var light_blue = const Color(0xff4D6275);
final toolbarTextStyle = TextStyle(color: Colors.white, fontSize: 16.0);

class BingoCardScreen extends StatefulWidget {
  BingoCardScreen({Key key}) : super(key: key);

  @override
  _BingoCardScreen createState() => _BingoCardScreen();
}

class _BingoCardScreen extends State<BingoCardScreen> {
  // TODO no entities in view layer
  BingoCard _card_in_play;

  @override
  void initState() {
    var useCase = BingoCardUseCase();
    useCase.playWithLatestBingoCard().then((bc) {
      setState( () => _card_in_play = bc );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_card_in_play == null)
      return Container();

    print('gap');

    return PlatformScaffold(
      backgroundColor: light_blue,
      body: _buildBingoCardContent(context),
    );
  }

  Widget _buildBingoCardContent(BuildContext context) {
    return Column( children: <Widget>[
      SizedBox(height: 24),
      // Screen's Title
      Container(
        child: Text('Fitness Bingo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 45,
            fontWeight: FontWeight.w800
          )
        )
      ),
      SizedBox(height: 14),
      // Card's Title
      Container(
        child: Text(_card_in_play.title,
          style: TextStyle(
            color: Colors.black
          )
        )
      ),
      SizedBox(height: 18),
      _buildBingoCard_asGridView(context)]
    );
  }

  Widget _buildBingoCard_asGridView(BuildContext context) {
    var myList = <Item>[];
    for (var bca in _card_in_play.activities) {
      var activity = Item(bca.category);
      activity.id = bca.location;
      myList.add(activity);
    }
    buildActivitySquare(Item data) {
      var activity = () {
        var idx = _card_in_play.activities.indexWhere(
                (e) => e.location == data.id);
        return _card_in_play.activities.elementAt(idx);
      };
      return GestureDetector(
        onTap: () {
          print("Going to activity details from ${data.location()}");
          Navigator.push(context, platformPageRoute(
            builder: (context) => ActivityDetailsScreen(activity: activity()),
            context: context
          ));
        },
        child: Container(
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 8),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 14),
            ]
          ),
        )
      );
    }

    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 6, right: 6),
        crossAxisCount: 5,
        crossAxisSpacing: 3,
        mainAxisSpacing: 5,
        children: myList.map(buildActivitySquare).toList()
      ),
    );
  }
}

