import 'package:xmoves/domain/bingo_card.dart';
import 'package:xmoves/application/bingo_card_repository.dart';

//class InMemoryCodecastGateway extends GatewayUtilities<Codecast> implements CodecastGateway {
class InMemoryBingoCardRepository implements BingoCardRepository {
  @override
  Future<BingoCard> pickMostRecent() {
    // TODO: implement pickMostRecent
    return Future.value(BingoCard(id: 1));
  }

}
