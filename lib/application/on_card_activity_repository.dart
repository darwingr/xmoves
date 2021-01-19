import 'package:xmoves/domain/on_card_activity.dart';
import 'package:xmoves/domain/bingo_card.dart';

abstract class OnCardActivityRepository {
  Future<OnCardActivity> findOnCardActivitiesForCard(BingoCard card);
}
