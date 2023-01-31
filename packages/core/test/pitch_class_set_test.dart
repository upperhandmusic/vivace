import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:vivace_core/src/pitch_class_set.dart';
import 'package:vivace_core/vivace_core.dart';

void main() {
  group('PitchClassSet', () {
    test('is not modifiable once created', () {
      var pcs = PitchClassSet.from([2, 7, 0, 3]);
      expect(pcs, isA<UnmodifiableSetView>());
    });

    group('from', () {
      test('creates a set of pitch classes from an iterable of integers', () {
        var pcsList = PitchClassSet.from([0, 1, 2]);
        expect(pcsList, equals({PitchClass.C, PitchClass.Db, PitchClass.D}));

        var pcsSet = PitchClassSet.from({0, 1, 2});
        expect(pcsSet, equals({PitchClass.C, PitchClass.Db, PitchClass.D}));
      });

      test('creates a sorted set of pitch classes', () {
        var pcs = PitchClassSet.from([2, 7, 0, 3]);
        expect(pcs,
            equals({PitchClass.C, PitchClass.D, PitchClass.Eb, PitchClass.G}));
      });

      test('only contains unique pitch classes', () {
        var pcs = PitchClassSet.from([7, 3, 2, 0, 3]);
        expect(pcs,
            equals({PitchClass.C, PitchClass.D, PitchClass.Eb, PitchClass.G}));
      });

      test('throws an error if numbers are outside valid pitch class range',
          () {
        expect(() => PitchClassSet.from([-1, 3, 8]), throwsRangeError);
        expect(() => PitchClassSet.from([3, 8, 12]), throwsRangeError);
      });
    });
  });
}
