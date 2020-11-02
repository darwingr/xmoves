import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'entities/bingo_card_activity.dart';

class ActivityDetailsScreen extends StatelessWidget {
  final BingoCardActivity activity;

  ActivityDetailsScreen({Key key, @required this.activity}) : super(key: key);

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
                    activity.title,
                    //'Facetime workout w friend',
                    // OR textTheme.headline5
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  activity.category,
                  //'sweat',
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
        activity.instructions,
        //'Do a workout with a friend over video chat.\n\n'
        //'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        //    'Alps. Situated 1,578 meters above sea level, it is one of the '
        //    'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        //    'half-hour walk through pastures and pine forest, leads you to the '
        //    'lake, which warms to 20 degrees Celsius in the summer. Activities '
        //    'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
        //style: textTheme.bodyText1
      ),
    );

    Color buttonColor = Theme.of(context).primaryColor;
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(buttonColor, Icons.call, 'CALL'),
          _buildButtonColumn(buttonColor, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(buttonColor, Icons.share, 'SHARE'),
        ],
      ),
    );

    return PlatformScaffold(
        // Goback '<' arrow also shows in header, done by PlatformAppBar
        appBar: PlatformAppBar(title: PlatformText("Activity Details")),
        body: ListView(children: <Widget>[
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
                      style: TextStyle(color: Colors.black))))
        ]));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
