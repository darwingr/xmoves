import 'package:xmoves/domain/bingo_card.dart';

abstract class BingoCardRepository {
  Future<BingoCard> pickMostRecent();
}

