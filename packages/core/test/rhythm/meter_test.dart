import 'package:test/test.dart';
import 'package:vivace_core/rhythm.dart';
import 'package:vivace_core/src/helpers/_binary.dart';

void main() {
  group('Meter()', () {
    test('creates a simple meter from the given beat count', () {
      final twoFour = Meter(2, NoteValue.quarter);
      final threeFour = Meter(3, NoteValue.quarter);
      final fourFour = Meter(4, NoteValue.quarter);

      expect(twoFour.id, equals('1010'.toBinary()));
      expect(twoFour.beatsPerCycle, 2);
      expect(twoFour.divisionsPerCycle, 4);
      expect(twoFour.value, NoteValue.quarter);

      expect(threeFour.id, equals('101010'.toBinary()));
      expect(threeFour.beatsPerCycle, 3);
      expect(threeFour.divisionsPerCycle, 6);
      expect(threeFour.value, NoteValue.quarter);

      expect(fourFour.id, equals('10101010'.toBinary()));
      expect(fourFour.beatsPerCycle, 4);
      expect(fourFour.divisionsPerCycle, 8);
      expect(fourFour.value, NoteValue.quarter);
    });

    test('creates a compound meter from the given beat count', () {
      final sixEight = Meter(6, NoteValue.eighth);
      final nineEight = Meter(9, NoteValue.eighth);
      final twelveEight = Meter(12, NoteValue.eighth);

      expect(sixEight.id, equals('100100'.toBinary()));
      expect(sixEight.beatsPerCycle, 2);
      expect(sixEight.divisionsPerCycle, 6);
      expect(sixEight.value, NoteValue.eighth);

      expect(nineEight.id, equals('100100100'.toBinary()));
      expect(nineEight.beatsPerCycle, 3);
      expect(nineEight.divisionsPerCycle, 9);
      expect(nineEight.value, NoteValue.eighth);

      expect(twelveEight.id, equals('100100100100'.toBinary()));
      expect(twelveEight.beatsPerCycle, 4);
      expect(twelveEight.divisionsPerCycle, 12);
      expect(twelveEight.value, NoteValue.eighth);
    });

    test('creates a complex meter from the given beat count', () {
      final fiveEight = Meter(5, NoteValue.eighth);
      final sevenEight = Meter(7, NoteValue.eighth);
      final eightEight = Meter(8, NoteValue.eighth);
      final elevenEight = Meter(11, NoteValue.eighth);

      expect(fiveEight.id, equals('10010'.toBinary()));
      expect(fiveEight.beatsPerCycle, 2);
      expect(fiveEight.divisionsPerCycle, 5);
      expect(fiveEight.value, NoteValue.eighth);

      expect(sevenEight.id, equals('1001010'.toBinary()));
      expect(sevenEight.beatsPerCycle, 3);
      expect(sevenEight.divisionsPerCycle, 7);
      expect(sevenEight.value, NoteValue.eighth);

      expect(eightEight.id, equals('10010010'.toBinary()));
      expect(eightEight.beatsPerCycle, 3);
      expect(eightEight.divisionsPerCycle, 8);
      expect(eightEight.value, NoteValue.eighth);

      expect(elevenEight.id, equals('10010010010'.toBinary()));
      expect(elevenEight.beatsPerCycle, 4);
      expect(elevenEight.divisionsPerCycle, 11);
      expect(elevenEight.value, NoteValue.eighth);
    });

    test('allows setting a custom beat grouping', () {
      final sevenEight1 = Meter(7, NoteValue.eighth);
      final sevenEight2 = Meter(7, NoteValue.eighth, grouping: const [2, 2, 3]);
      final sevenEight3 = Meter(7, NoteValue.eighth, grouping: const [2, 3, 2]);

      expect(sevenEight1.id, equals('1001010'.toBinary()));
      expect(sevenEight1.beatsPerCycle, 3);
      expect(sevenEight1.divisionsPerCycle, 7);
      expect(sevenEight1.value, NoteValue.eighth);

      expect(sevenEight2.id, equals('1010100'.toBinary()));
      expect(sevenEight2.beatsPerCycle, 3);
      expect(sevenEight2.divisionsPerCycle, 7);
      expect(sevenEight2.value, NoteValue.eighth);

      expect(sevenEight3.id, equals('1010010'.toBinary()));
      expect(sevenEight3.beatsPerCycle, 3);
      expect(sevenEight3.divisionsPerCycle, 7);
      expect(sevenEight3.value, NoteValue.eighth);
    });
  });

  group('Meter.simpleDuple()', () {
    test('creates a 2/4 meter by default', () {
      const meter = Meter.simpleDuple();

      expect(meter.beatsPerCycle, 2);
      expect(meter.divisionsPerCycle, 4);
      expect(meter.value, NoteValue.quarter);
      expect(meter.id, equals('1010'.toBinary()));
    });

    test('allows setting the note value per beat', () {
      const meter = Meter.simpleDuple(NoteValue.half);

      expect(meter.beatsPerCycle, 2);
      expect(meter.divisionsPerCycle, 4);
      expect(meter.value, NoteValue.half);
      expect(meter.id, equals('1010'.toBinary()));
    });
  });

  group('Meter.simpleTriple()', () {
    test('creates a 3/4 meter by default', () {
      const meter = Meter.simpleTriple();

      expect(meter.beatsPerCycle, 3);
      expect(meter.divisionsPerCycle, 6);
      expect(meter.value, NoteValue.quarter);
      expect(meter.id, equals('101010'.toBinary()));
    });

    test('allows setting the note value per beat', () {
      const meter = Meter.simpleTriple(NoteValue.eighth);

      expect(meter.beatsPerCycle, 3);
      expect(meter.divisionsPerCycle, 6);
      expect(meter.value, NoteValue.eighth);
      expect(meter.id, equals('101010'.toBinary()));
    });
  });

  group('Meter.simpleQuadruple()', () {
    test('creates a 4/4 meter by default', () {
      const meter = Meter.simpleQuadruple();

      expect(meter.beatsPerCycle, 4);
      expect(meter.divisionsPerCycle, 8);
      expect(meter.value, NoteValue.quarter);
      expect(meter.id, equals('10101010'.toBinary()));
    });

    test('allows setting the note value per beat', () {
      const meter = Meter.simpleQuadruple(NoteValue.half);

      expect(meter.beatsPerCycle, 4);
      expect(meter.divisionsPerCycle, 8);
      expect(meter.value, NoteValue.half);
      expect(meter.id, equals('10101010'.toBinary()));
    });
  });

  group('Meter.classification', () {
    test('returns simple if each beat divides equally into two parts', () {
      //
    });
  });

  group('Meter equality', () {
    test('A == B when both id values are equal', () {
      final fourFour1 = Meter(4, NoteValue.quarter);
      final fourFour2 = Meter(4, NoteValue.quarter);

      expect(fourFour1, equals(fourFour2));
    });

    test('A != B when both id values are not equal', () {
      final sevenEight1 = Meter(7, NoteValue.eighth);
      final sevenEight2 = Meter(7, NoteValue.eighth, grouping: const [2, 2, 3]);
      final sevenEight3 = Meter(7, NoteValue.eighth, grouping: const [2, 3, 2]);

      expect(sevenEight1, isNot(equals(sevenEight2)));
      expect(sevenEight1, isNot(equals(sevenEight3)));
      expect(sevenEight2, isNot(equals(sevenEight3)));
    });
  });

  group('Meter.toString()', () {
    test('returns a human readable representation of the meter', () {
      final simple = Meter(4, NoteValue.quarter);
      final compound = Meter(6, NoteValue.eighth);
      final complex = Meter(7, NoteValue.sixteenth);

      expect(simple.toString(), equals('4/4'));
      expect(compound.toString(), equals('6/8'));
      expect(complex.toString(), equals('7/16 (3+2+2)'));
    });
  });
}
