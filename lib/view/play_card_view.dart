import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:xmoves/presentation/bingo_card_bloc.dart';

// TODO only access theme via context, leave theme.dart next to main.dart
import '../theme.dart';
import 'activity_details_view.dart';
import 'widgets/loading_widget.dart';
import 'widgets/message_display_widget.dart';


class PlayCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<BingoCardBloc>(context);

    return PlatformScaffold(
      backgroundColor: lightBlue,
      body: BlocBuilder<BingoCardBloc, BingoCardState>(
        cubit: cardBloc,
        builder: (context, state) {
          if (state is BingoCardViewModel) {
            return _buildBingoCardContent(context, state);
          } else if (state is BingoCardInitial) {
            return LoadingWidget();
          } else {
            return MessageDisplay(
                message: "Bloc Error: returned unexpected state");
          }
        }
      ),
    );
  }

  Widget _buildBingoCardContent(BuildContext context,
      BingoCardViewModel cardInPlay)
  {
    return Column(children: <Widget>[
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
          child:
              Text(cardInPlay.title, style: TextStyle(color: Colors.black))),
      SizedBox(height: 18),
      Flexible(
        child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 6, right: 6),
          crossAxisCount: 5,
          crossAxisSpacing: 3,
          mainAxisSpacing: 5,
          children: cardInPlay.activities
              .map((activity) => _buildActivityTileWidget(context, activity))
              .toList()),
      )
    ]);
  }

  Widget _buildActivityTileWidget(BuildContext context, ActivityTile activity)=>
    GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute<Widget>(
                builder: (context) => ActivityDetailsView(
                      column: activity.column,
                      row:    activity.row),
                context: context));
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
                activity.category,
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 14),
            ]),
      ));
}
