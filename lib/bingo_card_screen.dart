import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';



class ActivityCategory {
  String label;
  //Color  colour;
  //String img;

  ActivityCategory(this.label);
}

class Item {
  int id;
  String title;
  String subtitle;
  String event = "Incomplete";
  String img;
  //Item({this.title, this.subtitle, this.event, this.img});
  Item(retitle) :
    this.id = 0,
    this.title = retitle,
    this.subtitle = retitle,
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

class ActivityDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Facetime workout w friend',
                    // OR textTheme.headline5
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'sweat',
                  // OR textTheme.subtitle1
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          //Icon(
          //  Icons.star,
          //  color: Colors.red[500],
          //),
          //Text('41'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Do a workout with a friend over video chat.\n\n'
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
      //style: textTheme.bodyText1
      ),
    );

    return PlatformScaffold(
      // Goback '<' arrow also shows in header, done by PlatformAppBar
      appBar: PlatformAppBar(title: PlatformText("Activity Details")),
      body: ListView(
        children: <Widget>[
          // Activity Title
          // Subtitle: Category of activity
          titleSection,
          // Description text
          textSection,
          // Click to mark complete
          //buttonSection,
          Center(
            child: PlatformButton(
              color: Colors.white,
              onPressed: () {
                print("Completed!");
                Navigator.pop(context);
              },
              child: PlatformText('Complete',
                style: TextStyle(color: Colors.black))
            )
          )
        ]
      )
    );
  }
}

class BingoCardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      //appBar: PlatformAppBar(
      //  title: Text(
      //    'Fitness Bingo',
      //    style: toolbarTextStyle,
      //  ),
      //  ios: (_) => CupertinoNavigationBarData(
      //    transitionBetweenRoutes: false,
      //    leading: PlatformButton(
      //      padding: EdgeInsets.all(4.0),
      //      child: Icon(Icons.arrow_back, color: Colors.white),
      //      onPressed: () {
      //        Navigator.of(context).pop();
      //      },
      //    ),
      //  ),
      //),
      backgroundColor: light_blue,
      body: _buildBingoCardContent(context),
    );
  }

  _buildBingoCardContent(BuildContext context) {
    return Column( children: <Widget>[
      SizedBox(height: 24),
      // Screen's Title
      Container(
        child: Text('Fitness Bingo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 45,
            fontWeight: FontWeight.w800))),
      SizedBox(height: 14),
      // Card's Title
      Container(
        child: Text('isolation edition',
          style: TextStyle(
            color: Colors.black))),
      SizedBox(height: 18),
      _buildBingoCard_asGridView(context)]);
  }

  _buildBingoCard_asGridView(BuildContext context) {
    var categories = <String>["Sweat", "Reflect/Relax", "Focus", "Move",
                              "Explore"];
    var myList = <Item>[];
    for (int i=0; i<5; i++) {
      for (int j=0; j<5; j++) {
        //myList.addAll(categories.map( (c) => Item(c) ));
        var activity = Item(categories[j]);
        activity.id = ((i+1) * 10) + j+1;
        myList.add(activity);
      }
    }
    buildActivitySquare(Item data) {
      return GestureDetector(
        onTap: () {
          print("Going to activity details from ${data.location()}");
          Navigator.push(context, platformPageRoute(
            builder: (context) => ActivityDetailsScreen(),
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
              //Image.asset(
              //  data.img,
              //  width: 42,
              //),
              //SizedBox(
              //  height: 14,
              //),
              //Text(
              //  data.title,
              //  style: TextStyle(
              //      color: Colors.white,
              //      fontSize: 16,
              //      fontWeight: FontWeight.w600),
              //),
              SizedBox(
                height: 8,
              ),
              Text(
                data.subtitle,
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 14,
              ),
              //Text(
              //  data.event,
              //  style: TextStyle(
              //      color: Colors.white70,
              //      fontSize: 11,
              //      fontWeight: FontWeight.w600),
              //),
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
          children: myList.map(buildActivitySquare).toList()),
    );
  }

  Table _buildBingoCardContent_asTable() {
    var categories = <String>["Sweat", "Reflect/Relax", "Focus", "Move",
                              "Explore"];
    buildCell(category) {
      return TableCell(child: Text(category));
    }
    buildRow(idx) {
      return TableRow( children: categories.map(buildCell).toList() );
    }

    return Table( children: List<TableRow>.generate(5, buildRow) );
  }
}

