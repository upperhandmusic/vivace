import 'package:test/test.dart';
import 'package:vivace_core/src/pitch/pitch.dart';
import 'package:vivace_core/src/pitch/pitch_class.dart';

import 'matchers.dart';
import 'support/helpers.dart';

void main() {
  group('Pitch', () {
    test('is equal to another pitch with the same pitch class and octave', () {
      const p1 = Pitch(pitchClass: PitchClass.A, octave: Octave(4));
      const p2 = Pitch(pitchClass: PitchClass.A, octave: Octave(4));
      expect(p1, equals(p2));
    });

    test('is not equal to another pitch with a different pitch class or octave',
        () {
      const p1 = Pitch(pitchClass: PitchClass.A, octave: Octave(4));
      const p2 = Pitch(pitchClass: PitchClass.B, octave: Octave(4));
      const p3 = Pitch(pitchClass: PitchClass.A, octave: Octave(5));
      expect(p1, isNot(equals(p2)));
      expect(p1, isNot(equals(p3)));
    });

    group('constructor', () {
      test('creates a pitch with the given pitch class and octave', () {
        const pc = PitchClass.C;
        const octave = Octave(4);
        const p = Pitch(pitchClass: pc, octave: octave);
        expect(p.pitchClass, equals(pc));
        expect(p.octave, equals(octave));
      });

      test('throws an error when octave is out of allowed range', () {
        expect(
          () => Pitch(pitchClass: PitchClass.A, octave: Octave(-2)),
          throwsAssertionError,
        );
        expect(
          () => const Pitch(pitchClass: PitchClass.A, octave: Octave(-1)),
          returnsNormally,
        );
        expect(
          () => const Pitch(pitchClass: PitchClass.A, octave: Octave(10)),
          returnsNormally,
        );
        expect(
          () => Pitch(pitchClass: PitchClass.A, octave: Octave(11)),
          throwsAssertionError,
        );
      });
    });

    group('named', () {
      test('creates a Pitch from a given text name', () {
        expect(
          Pitch.named('C4'),
          equals(const Pitch(pitchClass: PitchClass.C, octave: Octave(4))),
        );
        expect(
          Pitch.named('Ab-1'),
          equals(const Pitch(pitchClass: PitchClass.Ab, octave: Octave(-1))),
        );
        expect(
          Pitch.named('F#7'),
          equals(const Pitch(pitchClass: PitchClass.Gb, octave: Octave(7))),
        );
        expect(
          Pitch.named('E10'),
          equals(const Pitch(pitchClass: PitchClass.E, octave: Octave(10))),
        );
      });

      test('throws an error for an unsupported text name', () {
        expect(() => Pitch.named('P#3'), throwsArgumentError);
        expect(() => Pitch.named('F@-1'), throwsArgumentError);
        expect(() => Pitch.named('Abb9'), throwsArgumentError);
        expect(() => Pitch.named('G##5'), throwsArgumentError);
        expect(() => Pitch.named('B-2'), throwsAssertionError);
        expect(() => Pitch.named('E33'), throwsAssertionError);
      });
    });

    group('==', () {
      test('returns true if two Pitches have the same pitch class and octave',
          () {
        const pitchA = Pitch(pitchClass: PitchClass.C, octave: Octave(4));
        const pitchB = Pitch(pitchClass: PitchClass.C, octave: Octave(4));

        expect(pitchA == pitchB, isTrue);
      });

      test(
          'returns false if two Pitches have different pitch classes '
          'or octaves', () {
        const pitchA = Pitch(pitchClass: PitchClass.C, octave: Octave(4));
        const pitchB = Pitch(pitchClass: PitchClass.C, octave: Octave(5));
        const pitchC = Pitch(pitchClass: PitchClass.D, octave: Octave(4));

        expect(pitchA == pitchB, isFalse);
        expect(pitchA == pitchC, isFalse);
      });
    });

    hasComparability(
      const Pitch(pitchClass: PitchClass.C, octave: Octave(4)),
      const Pitch(pitchClass: PitchClass.C, octave: Octave(5)),
    );
  });
}
