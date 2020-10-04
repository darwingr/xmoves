import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';



class ActivityCategory {
  String label;
  //Color  colour;
  //String img;

  ActivityCategory(this.label);
}

class Item {
  String title;
  String subtitle;
  String event = "Incomplete";
  String img;
  //Item({this.title, this.subtitle, this.event, this.img});
  Item(retitle) :
    this.title = retitle,
    this.subtitle = retitle,
    this.event = "Incomplete",
    this.img = "images/AppIcon-128.png";
}

// Theme Data (hex format, precede with 0xff)
// Dark Blue:   0xff3A5067
var dark_blue = const Color(0xff3A5067);
// Light Blue:  0xff4D6275
var light_blue = const Color(0xff4D6275);

final toolbarTextStyle = TextStyle(color: Colors.white, fontSize: 16.0);

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext contex) {
    return PlatformScaffold(
      //appBar: PlatformAppBar(title: Text("Sendon Route")),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                print("Going back");
              },
              child: PlatformText('Go back!'))
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
      body: _buildBingoCardContent(),
    );
  }

  _buildBingoCardContent() {
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
      _buildBingoCard_asGridView()]);
  }

  _buildBingoCard_asGridView() {
    var categories = <String>["Sweat", "Reflect/Relax", "Focus", "Move",
                              "Explore"];
    var myList = <Item>[];
    for (int i=0; i<5; i++) {
      myList.addAll(categories.map( (c) => Item(c) ));
    }
    buildActivitySquare(Item data) {
      return Container(
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

