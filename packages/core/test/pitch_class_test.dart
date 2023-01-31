import 'package:vivace_core/src/pitch_class.dart';
import 'package:test/test.dart';

void main() {
  group('PitchClass', () {
    test('is equal to another pitch class with the same enumerated name', () {
      expect(PitchClass.C, equals(PitchClass.C));
      expect(PitchClass.Db, equals(PitchClass.Db));
      expect(PitchClass.D, equals(PitchClass.D));
      expect(PitchClass.Eb, equals(PitchClass.Eb));
      expect(PitchClass.E, equals(PitchClass.E));
      expect(PitchClass.F, equals(PitchClass.F));
      expect(PitchClass.Gb, equals(PitchClass.Gb));
      expect(PitchClass.G, equals(PitchClass.G));
      expect(PitchClass.Ab, equals(PitchClass.Ab));
      expect(PitchClass.A, equals(PitchClass.A));
      expect(PitchClass.Bb, equals(PitchClass.Bb));
      expect(PitchClass.B, equals(PitchClass.B));
    });

    test('can be sorted in a List', () {
      var pitchClasses = [PitchClass.G, PitchClass.E, PitchClass.Eb];

      pitchClasses.sort();

      expect(pitchClasses, equals([PitchClass.Eb, PitchClass.E, PitchClass.G]));
    });

    test('can be compared against other pitch classes', () {
      expect(PitchClass.C, lessThan(PitchClass.Db));
      expect(PitchClass.A, greaterThan(PitchClass.Eb));
      expect(PitchClass.E, lessThanOrEqualTo(PitchClass.E));
      expect(PitchClass.Eb, lessThanOrEqualTo(PitchClass.E));
      expect(PitchClass.G, greaterThanOrEqualTo(PitchClass.G));
      expect(PitchClass.Ab, greaterThanOrEqualTo(PitchClass.G));
    });
  });

  group('from', () {
    test('creates a PitchClass from the given int', () {
      expect(PitchClass.from(0), equals(PitchClass.C));
      expect(PitchClass.from(1), equals(PitchClass.Db));
      expect(PitchClass.from(2), equals(PitchClass.D));
      expect(PitchClass.from(3), equals(PitchClass.Eb));
      expect(PitchClass.from(4), equals(PitchClass.E));
      expect(PitchClass.from(5), equals(PitchClass.F));
      expect(PitchClass.from(6), equals(PitchClass.Gb));
      expect(PitchClass.from(7), equals(PitchClass.G));
      expect(PitchClass.from(8), equals(PitchClass.Ab));
      expect(PitchClass.from(9), equals(PitchClass.A));
      expect(PitchClass.from(10), equals(PitchClass.Bb));
      expect(PitchClass.from(11), equals(PitchClass.B));
    });

    test('throws an error for set numbers that are outside the correct range',
        () {
      expect(() => PitchClass.from(-1), throwsRangeError);
      expect(() => PitchClass.from(12), throwsRangeError);
    });
  });

  group('setNumber', () {
    test('is the standard set number for the pitch class', () {
      expect(PitchClass.C.setNumber, equals(0));
      expect(PitchClass.Db.setNumber, equals(1));
      expect(PitchClass.D.setNumber, equals(2));
      expect(PitchClass.Eb.setNumber, equals(3));
      expect(PitchClass.E.setNumber, equals(4));
      expect(PitchClass.F.setNumber, equals(5));
      expect(PitchClass.Gb.setNumber, equals(6));
      expect(PitchClass.G.setNumber, equals(7));
      expect(PitchClass.Ab.setNumber, equals(8));
      expect(PitchClass.A.setNumber, equals(9));
      expect(PitchClass.Bb.setNumber, equals(10));
      expect(PitchClass.B.setNumber, equals(11));
    });
  });
}
