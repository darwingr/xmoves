library lib_privacy;

import 'package:test/test.dart';
import 'neighbor_file.dart' as neighbor_file;
import 'neighbor_lib.dart'  as neighbor_lib;

part "lib_privacy.dart";

class _PrivateClassInSameFile {
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
      var obj = _PrivateClassInSameFile();
      expect(obj, isA<_PrivateClassInSameFile>());
    });

    test('#data can be read', () {
      var obj = _PrivateClassInSameFile();
      expect(obj.data, "accessible string");
    });

    test('#data can be mutated', () {
      var obj = _PrivateClassInSameFile();
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
        var obj = neighbor_file.PublicClassInImportedFile();
        expect(obj, isA<neighbor_file.PublicClassInImportedFile>());
      });

      test('#data can be read', () {
        var obj = neighbor_file.PublicClassInImportedFile();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = neighbor_file.PublicClassInImportedFile();
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
        var obj = PublicClassInCurrentLib();
        expect(obj, isA<PublicClassInCurrentLib>());
      });

      test('#data can be read', () {
        var obj = PublicClassInCurrentLib();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = PublicClassInCurrentLib();
        var before = obj.data;
        var after = "mutated string";
        obj.data = after;
        expect(before, "accessible string");
        expect(obj.data, after);
      });
    });

    group('_PrivateClass_inCurrentLib', () {
      test('() constructor succeeds', () {
        var obj = _PrivateClassInCurrentLib();
        expect(obj, isA<_PrivateClassInCurrentLib>());
      });

      test('#data can be read', () {
        var obj = _PrivateClassInCurrentLib();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = _PrivateClassInCurrentLib();
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
        var obj = neighbor_lib.PublicClassInImportedLib();
        expect(obj, isA<neighbor_lib.PublicClassInImportedLib>());
      });

      test('#data can be read', () {
        var obj = neighbor_lib.PublicClassInImportedLib();
        expect(obj.data, "accessible string");
      });

      test('#data can be mutated', () {
        var obj = neighbor_lib.PublicClassInImportedLib();
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
