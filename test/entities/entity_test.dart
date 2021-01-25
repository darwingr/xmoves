import 'package:test/test.dart';
import 'package:xmoves/core/entity.dart';

class EntityInheritor extends Entity<int> {
  //FIXME: ID will always have to be assigned via the super() constructor.
  // Is this a big problem?
  // Will it be obvious?
  // Do I need to set @mustCallSuper on parent constructor?
  //NOTE: NOT ONCE NULL SAFETY IS ENABLED. Since id is marked final, any child
  // fails to initialize it, thus calling super(id:), will get compile time
  // errors.
  EntityInheritor({int id}): super(id: id);
}

class OverriddenInheritor extends Entity<int> {
  final String actualID;
  OverriddenInheritor ({int id, this.actualID}): super(id: id);

  @override
  List<Object> get identifiers => [actualID];
}

class ExtendingInheritor extends Entity<int> {
  final String actualID;
  ExtendingInheritor({int id, this.actualID}): super(id: id);

  @override
  List<Object> get identifiers => [id, actualID];
}

/// Reflects four(4) general properties of 'sameness' relating to determining
///   if an entity is unique in terms of its identity.
void main() {
  group('1st Property: two different Entities are not the same', () {
    test('for string ID', () {
      var e1 = Entity(id: "e1ID");
      var e2 = Entity(id: "e2ID");
      expect(e1.isSame(e2), isFalse);
    });

    test('for int ID', () {
      var e1 = Entity(id: 1);
      var e2 = Entity(id: 2);
      expect(e1.isSame(e2), isFalse);
    });

    group('even when different types of ID', () {
      test('where the string id parses to the same number', () {
        var id = '1';
        var e1 = Entity(id: id);
        var e2 = Entity(id: int.parse(id));
        expect(e1.isSame(e2), isFalse);
        expect(e2.isSame(e1), isFalse);
      });

      test('where number id can be stringified', () {
        var id = 1;
        var e1 = Entity(id: id);
        var e2 = Entity(id: id.toString());
        expect(e1.isSame(e2), isFalse);
        expect(e2.isSame(e1), isFalse);
      });

      test('where the literal number and string are compared', () {
        var e1 = Entity(id: 1);
        var e2 = Entity(id: '1');
        expect(e1.isSame(e2), isFalse);
        expect(e2.isSame(e1), isFalse);
      });
    });
  });

  group('2nd Property: one Entity is the same as itself', () {
    test('for string ID', () {
      var e1 = Entity(id: "e1ID");
      expect(e1.isSame(e1), isTrue);
    });

    test('for int ID', () {
      var e1 = Entity(id: 1);
      expect(e1.isSame(e1), isTrue);
    });
  });

  group('3rd Property: Entities with the same ID/identifiers are the same', () {
    test('for string ID', () {
      var id = "e1ID";
      var e1 = Entity(id: id);
      var e2 = Entity(id: id);
      expect(e1 == e2, isFalse);
      expect(e1.isSame(e2), isTrue);
    });

    test('for int ID', () {
      var id = 1;
      var e1 = Entity(id: id);
      var e2 = Entity(id: id);
      expect(e1 == e2, isFalse);
      expect(e1.isSame(e2), isTrue);
    });
  });

  group('4th Property: Entities with Null IDs are never same', () {
    test('default constructor, no parameters', () {
      var e1 = Entity<Object>();
      var e2 = Entity<Object>();
      expect(e1.id, isNull);
      expect(e2.id, isNull);
      expect(e1.id == e2.id, isTrue);
      expect(e1.isSame(e2), isFalse);
    });

    test('empty strings are as good as null', () {
      var e1 = Entity<String>(id: "");
      var e2 = Entity<String>(id: "");
      expect(e1.id, equals(''));
      expect(e2.id, equals(''));
      expect(e1.id == e2.id, isTrue);
      expect(e1.isSame(e2), isFalse);
    });
  });

  group('Entity subtypes', () {
    test('shall inherit identifiers as their own', () {
      var child = EntityInheritor(id: 888);

      expect(child is Entity, isTrue);
      expect(child.identifiers.first is int, isTrue);
    });

    group('that overrides with different identifiers', () {
      test('shall not have id in their identifiers', () {
        var e1 = OverriddenInheritor(id: 1, actualID: "88");

        expect(e1.identifiers.length, 1);
        expect(e1.identifiers.first is String, isTrue);
      });
    });

    group('that adds to their identifiers', () {
      test('shall continue to have id in their identifiers', () {
        var e1 = ExtendingInheritor(id: 1, actualID: "88");

        expect(e1.identifiers.length, 2);
        expect(e1.identifiers.first is int, isTrue);
        expect(e1.identifiers[1] is String, isTrue);
      });
    });
  });
}
