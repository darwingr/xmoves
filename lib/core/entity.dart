import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

const DeepCollectionEquality _equality = DeepCollectionEquality();

/*
    From UncleBob Clean:
    - implements Cloneable
    - isSame
    - setID
    - getID
    - clone

    Entity (aka Reference Objects):
    - ENTITIES are defined by their identities.
      Attributes are attached and change.
    - a Mutable class with an identity used for tracking and persistence.
    - should be unique, therefore comparable
    - should follow safe-construction by default, like RAII,
      therefore try to avoid null initialization.
*/
class Entity<T extends Object> {
  @protected  // by default
  @visibleForTesting
  final T id;

  const Entity({this.id});

  /// identifiers define what make an entity unique
  List<Object> get identifiers => [id];

  // Use separate comparison than == for comparing identifiers,
  // thus changing the hash code and related mess is not necessary,
  // nor is requiring that it be immutable, which it shouldn't.
  bool isSame(Entity entity) =>
    identical(this, entity) ||
      entity is Entity<T> &&
        runtimeType == entity.runtimeType &&
        _equals(identifiers, entity.identifiers);


  /// Determines whether [list1] and [list2] are equal.
  bool _equals(List list1, List list2) {
    if (identical(list1, list2)) return true;
    if (list1 == null || list2 == null) return false;
    final length = list1.length;
    if (length != list2.length) return false;

    for (var i = 0; i < length; i++) {
      final dynamic unit1 = list1[i];
      final dynamic unit2 = list2[i];

      if (unit1 is Iterable || unit1 is Map) {
        if (!_equality.equals(unit1, unit2)) return false;
      } else if (unit1?.runtimeType != unit2?.runtimeType) {
        return false;
      } else if (unit1 != unit2) {
        return false;
      } else if (unit1 == null || unit2 == null) {
        return false;
      } else if (unit1 == '' || unit2 == '') {
        return false;
      }
    }
    return true;
  }
}
