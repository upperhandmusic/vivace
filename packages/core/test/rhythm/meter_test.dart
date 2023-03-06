import 'package:test/test.dart';
import 'package:vivace_core/rhythm.dart';
import 'package:vivace_core/src/helpers/_binary.dart';

void main() {
  group('Meter.fromList()', () {
    test('creates a simple meter from the given binary list metric structure',
        () {
      final twoFour = Meter.fromList([1, 0, 1, 0]);
      final threeFour = Meter.fromList([1, 0, 1, 0, 1, 0]);
      final fourFour = Meter.fromList([1, 0, 1, 0, 1, 0, 1, 0]);

      expect(twoFour.beatsPerCycle, 2);
      expect(twoFour.divisionsPerCycle, 4);
      expect(twoFour.noteValue, NoteValue.quarter);
      expect(twoFour.id, equals('1010'.toBinary()));

      expect(threeFour.beatsPerCycle, 3);
      expect(threeFour.divisionsPerCycle, 6);
      expect(threeFour.noteValue, NoteValue.quarter);
      expect(threeFour.id, equals('101010'.toBinary()));

      expect(fourFour.beatsPerCycle, 4);
      expect(fourFour.divisionsPerCycle, 8);
      expect(fourFour.noteValue, NoteValue.quarter);
      expect(fourFour.id, equals('10101010'.toBinary()));
    });

    test('creates a compound meter from the given binary list metric structure',
        () {
      final sixEight = Meter.fromList([1, 0, 0, 1, 0, 0], NoteValue.eighth);
      final nineEight =
          Meter.fromList([1, 0, 0, 1, 0, 0, 1, 0, 0], NoteValue.eighth);
      final twelveEight = Meter.fromList(
          [1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0], NoteValue.eighth);

      expect(sixEight.beatsPerCycle, 2);
      expect(sixEight.divisionsPerCycle, 6);
      expect(sixEight.noteValue, NoteValue.eighth);
      expect(sixEight.id, equals('100100'.toBinary()));

      expect(nineEight.beatsPerCycle, 3);
      expect(nineEight.divisionsPerCycle, 9);
      expect(nineEight.noteValue, NoteValue.eighth);
      expect(nineEight.id, equals('100100100'.toBinary()));

      expect(twelveEight.beatsPerCycle, 4);
      expect(twelveEight.divisionsPerCycle, 12);
      expect(twelveEight.noteValue, NoteValue.eighth);
      expect(twelveEight.id, equals('100100100100'.toBinary()));
    });

    test('creates a complex meter from the given binary list metric structure',
        () {
      final fiveEight = Meter.fromList([1, 0, 0, 1, 0], NoteValue.eighth);
      final sevenEight =
          Meter.fromList([1, 0, 0, 1, 0, 1, 0], NoteValue.eighth);
      final elevenEight =
          Meter.fromList([1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0], NoteValue.eighth);

      expect(fiveEight.beatsPerCycle, 2);
      expect(fiveEight.divisionsPerCycle, 5);
      expect(fiveEight.noteValue, NoteValue.eighth);
      expect(fiveEight.id, equals('10010'.toBinary()));

      expect(sevenEight.beatsPerCycle, 3);
      expect(sevenEight.divisionsPerCycle, 7);
      expect(sevenEight.noteValue, NoteValue.eighth);
      expect(sevenEight.id, equals('1001010'.toBinary()));

      expect(elevenEight.beatsPerCycle, 4);
      expect(elevenEight.divisionsPerCycle, 11);
      expect(elevenEight.noteValue, NoteValue.eighth);
      expect(elevenEight.id, equals('10010010010'.toBinary()));
    });
  });

  group('Meter.fromString()', () {
    test('creates a meter from the given binary string metric structure', () {
      final fourFour = Meter.fromString('10101010');

      expect(fourFour.beatsPerCycle, 4);
      expect(fourFour.noteValue, NoteValue.quarter);
      expect(fourFour.id, equals('10101010'.toBinary()));
    });

    test('allows meter creation with a custom note value', () {
      final fourTwo = Meter.fromString('10101010', NoteValue.half);

      expect(fourTwo.beatsPerCycle, 4);
      expect(fourTwo.noteValue, NoteValue.half);
      expect(fourTwo.id, equals('10101010'.toBinary()));
    });
  });

  // group('duple', () {
  //   test('creates a 2/4 meter by default', () {
  //     final meter = Meter.simpleDuple();
  //     expect(meter.beatsPerCycle, 2);
  //     expect(meter.noteValue, NoteValue.quarter);
  //   });

  //   test('allows setting the note value per beat', () {
  //     final meter = Meter.simpleDuple(NoteValue.half);
  //     expect(meter.beatsPerCycle, 2);
  //     expect(meter.noteValue, NoteValue.half);
  //   });
  // });

  // group('triple', () {
  //   test('creates a 3/4 meter be default', () {
  //     final meter = Meter.simpleTriple();
  //     expect(meter.beatsPerCycle, 3);
  //     expect(meter.noteValue, NoteValue.quarter);
  //   });

  //   test('allows setting the note value per beat', () {
  //     final meter = Meter.simpleTriple(NoteValue.half);
  //     expect(meter.beatsPerCycle, 3);
  //     expect(meter.noteValue, NoteValue.half);
  //   });
  // });

  group('Meter.classification', () {
    test('returns simple if each beat divides equally into two parts', () {
      // 1/4 2/4 3/4 4/4 5/4
      // [1, 2, 3, 4, 5]
      // final meter = Meter(1);
    });
  });

  group('Meter.toString()', () {
    test('returns a human readable representation of the meter', () {
      final simple = Meter.fromString('10101010');
      final compound = Meter.fromString('100100', NoteValue.eighth);
      final complex = Meter.fromString('1010100', NoteValue.sixteenth);

      expect(simple.toString(), equals('4/4'));
      expect(compound.toString(), equals('6/8'));
      expect(complex.toString(), equals('7/16'));
    });
  });
}
