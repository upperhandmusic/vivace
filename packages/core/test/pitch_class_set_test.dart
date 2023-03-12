import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:vivace_core/pitch.dart';

void main() {
  group('PitchClassSet', () {
    test('is not modifiable once created', () {
      final pcs = PitchClassSet.from([2, 7, 0, 3]);
      expect(pcs, isA<UnmodifiableSetView<int>>());
    });

    group('from', () {
      test('creates a set of pitch classes from an iterable of integers', () {
        final pcsList = PitchClassSet.from([0, 1, 2]);
        expect(pcsList, equals({PitchClass.C, PitchClass.Db, PitchClass.D}));

        final pcsSet = PitchClassSet.from({0, 1, 2});
        expect(pcsSet, equals({PitchClass.C, PitchClass.Db, PitchClass.D}));
      });

      test('creates a sorted set of pitch classes', () {
        final pcs = PitchClassSet.from([2, 7, 0, 3]);
        expect(
          pcs,
          equals({PitchClass.C, PitchClass.D, PitchClass.Eb, PitchClass.G}),
        );
      });

      test('only contains unique pitch classes', () {
        final pcs = PitchClassSet.from([7, 3, 2, 0, 3]);
        expect(
          pcs,
          equals({PitchClass.C, PitchClass.D, PitchClass.Eb, PitchClass.G}),
        );
      });

      test('throws an error if numbers are outside valid pitch class range',
          () {
        expect(() => PitchClassSet.from([-1, 3, 8]), throwsRangeError);
        expect(() => PitchClassSet.from([3, 8, 12]), throwsRangeError);
      });
    });
  });
}
