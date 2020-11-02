import 'package:test/test.dart';
import 'package:xmoves/entities/entity.dart';

void main() {
  test('two different Entities are not the same', () {
    var e1 = Entity(id: "e1ID");
    var e2 = Entity(id: "e2ID");
    expect(e1.isSame(e2), isFalse);
  });

  test('one Entity is the same as itself', () {
    var e1 = Entity(id: "e1ID");
    expect(e1.isSame(e1), isTrue);
  });

  test('Entities with the same ID are the same', () {
    var e1 = Entity(id: "eID");
    var e2 = Entity(id: "eID");
    expect(e1.isSame(e2), isTrue);
  });

  group('Entities with Null IDs are never same', () {
    test('default constructor, no parameters', () {
      var e1 = Entity();
      var e2 = Entity();
      expect(e1.id, isNull);
      expect(e2.id, isNull);
      expect(e1.id == e2.id, isTrue);
      expect(e1.isSame(e2), isFalse);
    });

    test('empty strings are as good as null', () {
      var e1 = Entity(id: "");
      var e2 = Entity(id: "");
      expect(e1.id, equals(''));
      expect(e2.id, equals(''));
      expect(e1.id == e2.id, isTrue);
      expect(e1.isSame(e2), isFalse);
    });
  });
}
