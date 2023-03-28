import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:vivace_core/pitch.dart';
import 'package:vivace_core/src/helpers/_binary.dart';
import 'package:vivace_core/tonality.dart';

import 'matchers.dart';

void main() {
  group('ScaleIterator()', () {
    test('creates an iterator of pitch classes', () {
      expect(ScaleIterator(1234), isA<Iterator<PitchClass>>());
    });
  });

  group('ScaleIterator.moveNext()', () {
    test('returns true when there are iterable pitch classes left', () {
      final identity = int.parse('001010100101', radix: 2);
      final iterator = ScaleIterator(identity);
      var count = 0;

      while (iterator.moveNext()) {
        count++;
      }

      expect(count, equals(identity.countEnabledBits()));
    });

    test('returns false when there are no iterable pitch classes left', () {
      final identity = int.parse('001010100101', radix: 2);
      final iterator = ScaleIterator(identity);

      while (iterator.moveNext()) {}

      expect(iterator.moveNext(), isFalse);
    });
  });

  group('ScaleIterator.current', () {
    test('throws an error if iteration has not started', () {
      final identity = int.parse('001010100101', radix: 2);
      final iterator = ScaleIterator(identity);
      expect(() => iterator.current, throwsStateError);
    });

    test('throws an error if iteration has finished', () {
      final identity = int.parse('001010100101', radix: 2);
      final iterator = ScaleIterator(identity);

      while (iterator.moveNext()) {
        expect(iterator.current, isA<PitchClass>());
      }

      expect(() => iterator.current, throwsStateError);
    });
  });

  group('Scale', () {
    test('implements an Iterable interface', () {
      const tonic = PitchClass.C;
      final identity = int.parse('101010110101', radix: 2);
      final scale = Scale(tonic: tonic, id: identity);

      expect(scale, isA<Iterable<PitchClass>>());
    });
  });

  group('Scale()', () {
    test('sets the scale tonic pitch class', () {
      const tonic = PitchClass.C;
      final identity = int.parse('101010110101', radix: 2);
      final scale = Scale(tonic: tonic, id: identity);
      expect(scale.tonic, equals(tonic));
    });

    test('sets the scale identity', () {
      const tonic = PitchClass.C;
      final identity = int.parse('101010110101', radix: 2);
      final scale = Scale(tonic: tonic, id: identity);
      expect(scale.id, equals(identity));
    });

    test('implements an iterable interface', () {
      const tonic = PitchClass.C;
      final identity = int.parse('101010110101', radix: 2);
      final scale = Scale(tonic: tonic, id: identity);
      final pitchClasses = [0, 2, 4, 5, 7, 9, 11].map(PitchClass.at);

      expect(scale, isA<Iterable<PitchClass>>());

      scale.forEachIndexed((index, element) {
        expect(element, equals(pitchClasses.elementAt(index)));
      });

      for (final element in pitchClasses) {
        expect(scale.contains(element), isTrue);
      }
    });
  });

  group('Scale.from()', () {
    test('creates a scale from iterable integers', () {
      final scaleList = Scale.from(const [0, 2, 4, 5, 7, 9, 11]);
      final scaleSet = Scale.from(const {0, 2, 4, 5, 7, 9, 11});
      const majorScale = Scale.major(PitchClass.C);

      expect(scaleList.id, equals(majorScale.id));
      expect(scaleSet.id, equals(majorScale.id));
    });

    test('sorts the input set numbers from low to high', () {
      const outOfOrder = [7, 0, 3, 1, 8, 5];
      final scale = Scale.from(outOfOrder);
      outOfOrder.sort();
      final pitchClasses = outOfOrder.map(PitchClass.at);

      expect(scale.ascending, equals(pitchClasses));
    }, skip: 'TODO fix immutable list error');

    test('deduplicates the list of pitch classes', () {},
        skip: 'TODO check for duplicates');

    test('sets the tonic to a pitch class from the lowest integer', () {},
        skip: 'TODO set tonic from low int');

    test('throws an error if list values exceed set number limits', () {
      const tooLow = [-1, 1, 3, 5, 7];
      const tooHigh = [0, 2, 4, 7, 12];

      expect(() => Scale.from(tooLow), throwsRangeError);
      expect(() => Scale.from(tooHigh), throwsRangeError);
    });
  });

  group('Scale.major()', () {
    test('creates a major scale with the given tonic', () {
      const tonic = PitchClass.C;
      const scale = Scale.major(tonic);
      expect(scale.id, equals(2741));
      expect(scale.tonic, equals(tonic));
    });
  });

  group('Scale.naturalMinor()', () {
    test('creates a harmonic minor scale with the given tonic', () {
      const tonic = PitchClass.C;
      const scale = Scale.naturalMinor(tonic);
      expect(scale.id, equals(1453));
      expect(scale.tonic, equals(tonic));
    });
  });

  group('Scale.harmonicMinor()', () {
    test('creates a harmonic minor scale with the given tonic', () {
      const tonic = PitchClass.C;
      const scale = Scale.harmonicMinor(tonic);
      expect(scale.id, equals(2477));
      expect(scale.tonic, equals(tonic));
    });
  });

  group('Scale.melodicMinor()', () {
    test('creates a melodic minor scale with the given tonic', () {
      const tonic = PitchClass.C;
      const scale = Scale.melodicMinor(tonic);
      expect(scale.id, equals(2733));
      expect(scale.tonic, equals(tonic));
    });
  });

  group('Scale.ascending', () {
    test('creates a Set of ascending scale pitch classes', () {
      const scale = Scale.major(PitchClass.C);

      expect(
        scale.ascending,
        orderedEquals({
          PitchClass.C,
          PitchClass.D,
          PitchClass.E,
          PitchClass.F,
          PitchClass.G,
          PitchClass.A,
          PitchClass.B,
        }),
      );
    });

    test('creates an unmodifiable Set', () {
      const scale = Scale.major(PitchClass.C);
      expect(() => scale.ascending.add(PitchClass.Ab), throwsUnsupportedError);
    });
  });

  group('Scale.descending', () {
    test('creates a Set of descending scale pitch classes', () {
      const scale = Scale.major(PitchClass.C);

      expect(
        scale.descending,
        orderedEquals({
          PitchClass.B,
          PitchClass.A,
          PitchClass.G,
          PitchClass.F,
          PitchClass.E,
          PitchClass.D,
          PitchClass.C,
        }),
      );
    });

    test('creates an unmodifiable Set', () {
      const scale = Scale.major(PitchClass.C);
      expect(() => scale.descending.add(PitchClass.Ab), throwsUnsupportedError);
    });
  });

  group('Scale.toSet()', () {
    test('returns a set of pitch classes in the Scale', () {
      const scale = Scale.major(PitchClass.C);
      expect(
        scale.toSet(),
        equals({
          PitchClass.C,
          PitchClass.D,
          PitchClass.E,
          PitchClass.F,
          PitchClass.G,
          PitchClass.A,
          PitchClass.B,
        }),
      );
    });
  });

  group('Scale.toList()', () {
    test('returns a list of pitch classes in the Scale', () {
      const scale = Scale.major(PitchClass.C);
      expect(
        scale.toList(),
        equals([
          PitchClass.C,
          PitchClass.D,
          PitchClass.E,
          PitchClass.F,
          PitchClass.G,
          PitchClass.A,
          PitchClass.B,
        ]),
      );
    });
  });

  group('Scale.==', () {
    test('returns true if the two scales have the same id and tonic', () {
      const scale1 = Scale.major(PitchClass.C);
      const scale2 = Scale.major(PitchClass.C);

      expect(scale1 == scale2, isTrue);
    });

    test('returns false if the two scales have different ids or tonics', () {
      const scale1 = Scale.major(PitchClass.C);
      const scale3 = Scale.major(PitchClass.G);
      const scale2 = Scale.naturalMinor(PitchClass.C);

      expect(scale1 == scale2, isFalse);
      expect(scale1 == scale3, isFalse);
    });
  });

  group('Scale.[]', () {
    test('returns the PitchClass at the ith scale degree', () {
      const scale = Scale.major(PitchClass.C);
      expect(scale[1], PitchClass.C);
      expect(scale[2], PitchClass.D);
      expect(scale[3], PitchClass.E);
      expect(scale[4], PitchClass.F);
      expect(scale[5], PitchClass.G);
      expect(scale[6], PitchClass.A);
      expect(scale[7], PitchClass.B);
    });
  });

  group('Scale.isSameTypeAs()', () {
    test('returns true if scales have the same id', () {
      const scale = Scale.major(PitchClass.C);
      const other = Scale.major(PitchClass.G);

      expect(scale.isSameTypeAs(other), isTrue);
    });

    test('returns false if scales have different ids', () {
      const scale = Scale.major(PitchClass.C);
      const other = Scale.naturalMinor(PitchClass.C);

      expect(scale.isSameTypeAs(other), isFalse);
    });
  });

  group('Scale.mode()', () {
    test('throws an error when mode number is < 1', () {
      const scale = Scale.major(PitchClass.C);
      expect(() => scale.mode(0), throwsAssertionError);
      expect(() => scale.mode(-1), throwsAssertionError);
    });

    test('throws an error when mode number is > number of possible modes', () {
      const scale = Scale.major(PitchClass.C);
      expect(() => scale.mode(8), throwsAssertionError);
    });

    test('creates a new Scale as the nth mode of the Scale', () {
      const cMajor = Scale.major(PitchClass.C);
      final ionian = cMajor.mode(1);
      final dorian = cMajor.mode(2);
      final phrygian = cMajor.mode(3);
      final lydian = cMajor.mode(4);
      final mixolydian = cMajor.mode(5);
      final aeolian = cMajor.mode(6);
      final locrian = cMajor.mode(7);

      expect(ionian.id, equals(cMajor.id));
      expect(ionian.tonic, equals(PitchClass.C));

      expect(dorian.id, equals(1709));
      expect(dorian.tonic, equals(PitchClass.D));

      expect(phrygian.id, equals(1451));
      expect(phrygian.tonic, equals(PitchClass.E));

      expect(lydian.id, equals(2773));
      expect(lydian.tonic, equals(PitchClass.F));

      expect(mixolydian.id, equals(1717));
      expect(mixolydian.tonic, equals(PitchClass.G));

      expect(aeolian.id, equals(1453));
      expect(aeolian.tonic, equals(PitchClass.A));

      expect(locrian.id, equals(1387));
      expect(locrian.tonic, equals(PitchClass.B));
    });
  });

  group('Scale.triads', () {
    test('gets the set of triads for degree in the scale', () {
      const scale = Scale.major(PitchClass.C);

      expect(
        scale.triads,
        equals([
          {PitchClass.C, PitchClass.E, PitchClass.G},
          {PitchClass.D, PitchClass.F, PitchClass.A},
          {PitchClass.E, PitchClass.G, PitchClass.B},
          {PitchClass.F, PitchClass.A, PitchClass.C},
          {PitchClass.G, PitchClass.B, PitchClass.D},
          {PitchClass.A, PitchClass.C, PitchClass.E},
          {PitchClass.B, PitchClass.D, PitchClass.F},
        ]),
      );
    });
  });
}
