import 'package:test/test.dart';
import 'package:vivace_core/src/scales.dart';
import 'package:vivace_core/src/pitch_class.dart';

import 'matchers.dart';

void main() {
  group('Scale', () {
    group('constructor', () {
      test('sets the scale tonic pitch class', () {
        var tonic = PitchClass.C;
        var identity = int.parse('101010110101', radix: 2);
        var scale = Scale(tonic: tonic, id: identity);
        expect(scale.tonic, equals(tonic));
      });

      test('sets the scale identity', () {
        var tonic = PitchClass.C;
        var identity = int.parse('101010110101', radix: 2);
        var scale = Scale(tonic: tonic, id: identity);
        expect(scale.id, equals(identity));
      });
    });

    group('fromList', () {
      test('creates a Scale from a list of pitch class integers', () {
        var tonic = PitchClass.C;
        var scale =
            Scale.fromList(tonic: tonic, pitchClasses: [0, 2, 4, 5, 7, 9, 11]);
        var majScale = Scale.major(tonic);

        expect(scale.id, equals(majScale.id));
      });
    });

    group('major', () {
      test('creates a major scale with the given tonic', () {
        final tonic = PitchClass.C;
        final scale = Scale.major(tonic);
        expect(scale.id, equals(2741));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('naturalMinor', () {
      test('creates a harmonic minor scale with the given tonic', () {
        final tonic = PitchClass.C;
        final scale = Scale.naturalMinor(tonic);
        expect(scale.id, equals(1453));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('harmonicMinor', () {
      test('creates a harmonic minor scale with the given tonic', () {
        final tonic = PitchClass.C;
        final scale = Scale.harmonicMinor(tonic);
        expect(scale.id, equals(2477));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('melodicMinor', () {
      test('creates a melodic minor scale with the given tonic', () {
        final tonic = PitchClass.C;
        final scale = Scale.melodicMinor(tonic);
        expect(scale.id, equals(2733));
        expect(scale.tonic, equals(tonic));
      });
    });

    group('toSet', () {
      test('returns a set of pitch classes in the Scale', () {
        var scale = Scale.major(PitchClass.C);
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
        var scale = Scale.major(PitchClass.C);
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
        var scale = Scale.major(PitchClass.C);
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
        var scale = Scale.major(PitchClass.C);
        expect(() => scale.mode(0), throwsAssertionError);
        expect(() => scale.mode(-1), throwsAssertionError);
      });

      test('throws an error when mode number is > number of possible modes',
          () {
        var scale = Scale.major(PitchClass.C);
        expect(() => scale.mode(8), throwsAssertionError);
      });

      test('creates a new Scale as the nth mode of the Scale', () {
        var cMajor = Scale.major(PitchClass.C);
        var ionian = cMajor.mode(1);
        var dorian = cMajor.mode(2);
        var phrygian = cMajor.mode(3);
        var lydian = cMajor.mode(4);
        var mixolydian = cMajor.mode(5);
        var aeolian = cMajor.mode(6);
        var locrian = cMajor.mode(7);

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
