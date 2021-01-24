import 'bingo_card_repository.dart';
import 'on_card_activity_repository.dart';

/// Collection of repository 'ports' to which 'adapters' may be set.
class RepositoryAdapters {
  static BingoCardRepository bingoCards;
  static OnCardActivityRepository onCardActivities;
}
