import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:vivace_core/src/pitch_class_set.dart';
import 'package:vivace_core/vivace_core.dart';

import 'matchers.dart';

void main() {
  group('PitchClassSet', () {
    test('is not modifiable once created', () {
      var pcs = PitchClassSet([2, 7, 0, 3]);
      expect(pcs, isA<UnmodifiableSetView>());
    });

    group('constructor', () {
      test('creates a sorted set of pitch classes', () {
        var pcs = PitchClassSet([2, 7, 0, 3]);
        expect(
            pcs,
            equals(
                {PitchClass(0), PitchClass(2), PitchClass(3), PitchClass(7)}));
      });

      test('only contains unique pitch classes', () {
        var pcs = PitchClassSet([7, 3, 2, 0, 3]);
        expect(
            pcs,
            equals(
                {PitchClass(0), PitchClass(2), PitchClass(3), PitchClass(7)}));
      });

      test('throws an error if numbers are outside valid pitch class range',
          () {
        expect(() => PitchClassSet([-1, 3, 8]), throwsAssertionError);
        expect(() => PitchClassSet([3, 8, 12]), throwsAssertionError);
      });
    });

    group('add', () {
      //
      test('throws an error', () {});
    });
  });
}
