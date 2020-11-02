library lib_privacy;

import 'package:test/test.dart';
import 'neighbor_file.dart' as neighbor_file;
import 'neighbor_lib.dart'  as neighbor_lib;

part "lib_privacy.dart";

class _PrivateClass_inSameFile {
  String data = "accessible string";
}

// This is a test of the language's behaviour around encapsulation and visibility
// at the top level of imported files and libraries.
// Privacy is supposed to work at the library level in dart therefore:
//  Every class declared in the same library can access each other’s private
//  members, but code outside of that library cannot.
//  https://dart.dev/guides/language/effective-dart/design#prefer-making-declarations-private
//
// For each situation will attempt to
//  instantiate the private class,
//  access its members.
void main() {
  group('_PrivateClass_inSameFile', () {
    test('() constructor succeeds', () {
      var obj = _PrivateClass_inSameFile();
      expect(obj, isA<_PrivateClass_inSameFile>());
    });

    test('#data can be read', () {
      var obj = _PrivateClass_inSameFile();
      expect(obj.data, "accessible string");
    });

    test('#data can be mutated', () {
      var obj = _PrivateClass_inSameFile();
      var before = obj.data;
      var after = "mutated string";
      obj.data = after;
      expect(before, "accessible string");
      expect(obj.data, after);
    });
  });

  // from neighboring file, relative reference
  group('neighbor_file.', () {
    group('PublicClass_inImportedFile', () {
      test('() constructor succeeds', () {
        var obj = neighbor_file.PublicClass_inImportedFile();
        expect(obj, isA<neighbor_file.PublicClass_inImportedFile>());
      });

      test('#data can be read', () {
        var obj = neighbor_file.PublicClass_inImportedFile();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = neighbor_file.PublicClass_inImportedFile();
        var before = obj.data;
        var after = "mutated string";
        obj.data = after;
        expect(before, "accessible string");
        expect(obj.data, after);
      });
    });

    group('_PrivateClass_inImportedFile', () {
      // TODO: intentional compilation error cannot be tested
      test('() constructor properly fails to compile', () {
        print("MANUALLY PASSED");
        //var obj = _PrivateClass_inImportedFile();
        //expect(neighbor_file, isUnimplementedError);
      });
    });
  });

  // from separate file but current library scope
  group('lib_privacy.', () {
    group('PlublicClass_inCurrentLib', () {
      test('() constructor succeeds', () {
        var obj = PublicClass_inCurrentLib();
        expect(obj, isA<PublicClass_inCurrentLib>());
      });

      test('#data can be read', () {
        var obj = PublicClass_inCurrentLib();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = PublicClass_inCurrentLib();
        var before = obj.data;
        var after = "mutated string";
        obj.data = after;
        expect(before, "accessible string");
        expect(obj.data, after);
      });
    });

    group('_PrivateClass_inCurrentLib', () {
      test('() constructor succeeds', () {
        var obj = _PrivateClass_inCurrentLib();
        expect(obj, isA<_PrivateClass_inCurrentLib>());
      });

      test('#data can be read', () {
        var obj = _PrivateClass_inCurrentLib();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = _PrivateClass_inCurrentLib();
        var before = obj.data;
        var after = "mutated string";
        obj.data = after;
        expect(before, "accessible string");
        expect(obj.data, after);
      });
    });
  });

  // from neighboring/external library
  group('neighbor_lib.', () {
    group('PlublicClass_inImportedLib', () {
      test('() constructor succeeds', () {
        var obj = neighbor_lib.PublicClass_inImportedLib();
        expect(obj, isA<neighbor_lib.PublicClass_inImportedLib>());
      });

      test('#data can be read', () {
        var obj = neighbor_lib.PublicClass_inImportedLib();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = neighbor_lib.PublicClass_inImportedLib();
        var before = obj.data;
        var after = "mutated string";
        obj.data = after;
        expect(before, "accessible string");
        expect(obj.data, after);
      });
    });

    group('_PrivateClass_inImportedLib', () {
      // TODO: intentional compilation error cannot be tested
      test('() constructor properly fails to compile', () {
        print("MANUALLY PASSED");
        //var obj = neighbor_lib._PrivateClass_inImportedLib();
        //expect(obj, );
      });
    });
  });
}
