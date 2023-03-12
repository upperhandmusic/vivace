import 'package:test/test.dart';
import 'package:vivace_core/pitch.dart';
import 'package:vivace_core/tonality.dart';

import 'matchers.dart';

void main() {
  group('Scale', () {
    group('constructor', () {
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
    });

    group('fromList', () {
      test('creates a Scale from a list of pitch class integers', () {
        const tonic = PitchClass.C;
        final scale =
            Scale.fromList(tonic: tonic, pitchClasses: [0, 2, 4, 5, 7, 9, 11]);
        const majScale = Scale.major(tonic);

        expect(scale.id, equals(majScale.id));
      });
    });

    group('major', () {
      test('creates a major scale with the given tonic', () {
        const tonic = PitchClass.C;
        const scale = Scale.major(tonic);
        expect(scale.id, equals(2741));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('naturalMinor', () {
      test('creates a harmonic minor scale with the given tonic', () {
        const tonic = PitchClass.C;
        const scale = Scale.naturalMinor(tonic);
        expect(scale.id, equals(1453));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('harmonicMinor', () {
      test('creates a harmonic minor scale with the given tonic', () {
        const tonic = PitchClass.C;
        const scale = Scale.harmonicMinor(tonic);
        expect(scale.id, equals(2477));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('melodicMinor', () {
      test('creates a melodic minor scale with the given tonic', () {
        const tonic = PitchClass.C;
        const scale = Scale.melodicMinor(tonic);
        expect(scale.id, equals(2733));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('toSet', () {
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
            }));
      });
    });

    group('toList', () {
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
            ]));
      });
    });

    group('[]', () {
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

    group('mode', () {
      test('throws an error when mode number is < 1', () {
        const scale = Scale.major(PitchClass.C);
        expect(() => scale.mode(0), throwsAssertionError);
        expect(() => scale.mode(-1), throwsAssertionError);
      });

      test('throws an error when mode number is > number of possible modes',
          () {
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
  });
}
