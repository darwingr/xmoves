import '../bingo_card_repository.dart';
import 'output_boundary.dart';

abstract class BingoCardInputBoundary {
  BingoCardInputBoundary(BingoCardRepository repo);
  Future<void> execute(BingoCardOutputBoundary presenter);
}
