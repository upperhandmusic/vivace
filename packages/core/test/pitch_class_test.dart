import 'package:test/test.dart';
import 'package:vivace_core/pitch.dart';

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
      final pitchClasses = [PitchClass.G, PitchClass.E, PitchClass.Eb]..sort();

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

  group('at', () {
    test('creates a PitchClass from the given int', () {
      expect(PitchClass.at(0), equals(PitchClass.C));
      expect(PitchClass.at(1), equals(PitchClass.Db));
      expect(PitchClass.at(2), equals(PitchClass.D));
      expect(PitchClass.at(3), equals(PitchClass.Eb));
      expect(PitchClass.at(4), equals(PitchClass.E));
      expect(PitchClass.at(5), equals(PitchClass.F));
      expect(PitchClass.at(6), equals(PitchClass.Gb));
      expect(PitchClass.at(7), equals(PitchClass.G));
      expect(PitchClass.at(8), equals(PitchClass.Ab));
      expect(PitchClass.at(9), equals(PitchClass.A));
      expect(PitchClass.at(10), equals(PitchClass.Bb));
      expect(PitchClass.at(11), equals(PitchClass.B));
    });

    test('throws an error for set numbers that are outside the correct range',
        () {
      expect(() => PitchClass.at(-1), throwsRangeError);
      expect(() => PitchClass.at(12), throwsRangeError);
    });
  });

  group('named', () {
    test('creates a PitchClass from the given note name', () {
      expect(PitchClass.named('C'), equals(PitchClass.C));
      expect(PitchClass.named('C#'), equals(PitchClass.Db));
      expect(PitchClass.named('Db'), equals(PitchClass.Db));
      expect(PitchClass.named('D'), equals(PitchClass.D));
      expect(PitchClass.named('D#'), equals(PitchClass.Eb));
      expect(PitchClass.named('Eb'), equals(PitchClass.Eb));
      expect(PitchClass.named('E'), equals(PitchClass.E));
      expect(PitchClass.named('F'), equals(PitchClass.F));
      expect(PitchClass.named('F#'), equals(PitchClass.Gb));
      expect(PitchClass.named('Gb'), equals(PitchClass.Gb));
      expect(PitchClass.named('G'), equals(PitchClass.G));
      expect(PitchClass.named('G#'), equals(PitchClass.Ab));
      expect(PitchClass.named('Ab'), equals(PitchClass.Ab));
      expect(PitchClass.named('A'), equals(PitchClass.A));
      expect(PitchClass.named('A#'), equals(PitchClass.Bb));
      expect(PitchClass.named('Bb'), equals(PitchClass.Bb));
      expect(PitchClass.named('B'), equals(PitchClass.B));
    });

    test('throws an error with an unsupported note name', () {
      expect(() => PitchClass.named('P#'), throwsArgumentError);
      expect(() => PitchClass.named('F##'), throwsArgumentError);
      expect(() => PitchClass.named('B*'), throwsArgumentError);
      expect(() => PitchClass.named('Dbb'), throwsArgumentError);
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
