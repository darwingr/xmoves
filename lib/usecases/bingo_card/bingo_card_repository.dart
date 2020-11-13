import 'package:xmoves/entities/bingo_card.dart';

abstract class BingoCardRepository {
  Future<BingoCard> pickMostRecent();
}

