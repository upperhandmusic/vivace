import 'package:test/test.dart';
import 'package:vivace_core/src/scales.dart';
import 'package:vivace_core/src/pitch_class.dart';

void main() {
  group('Scale', () {
    test('major creates a major scale with the given tonic', () {
      final tonic = PitchClass.cNatural;
      final scale = Scale.major(tonic);
      expect(scale.identity, equals(2741));
      expect(scale.tonic, equals(tonic));
    });

    test('naturalMinor creates a harmonic minor scale with the given tonic',
        () {
      final tonic = PitchClass.cNatural;
      final scale = Scale.naturalMinor(tonic);
      expect(scale.identity, equals(1453));
      expect(scale.tonic, equals(tonic));
    });

    test('harmonicMinor creates a harmonic minor scale with the given tonic',
        () {
      final tonic = PitchClass.cNatural;
      final scale = Scale.harmonicMinor(tonic);
      expect(scale.identity, equals(2477));
      expect(scale.tonic, equals(tonic));
    });

    test('melodicMinor creates a melodic minor scale with the given tonic', () {
      final tonic = PitchClass.cNatural;
      final scale = Scale.melodicMinor(tonic);
      expect(scale.identity, equals(2733));
      expect(scale.tonic, equals(tonic));
    });

    test('toSet returns a set of pitch classes in the Scale', () {
      var scale = Scale.major(PitchClass.cNatural);
      expect(
          scale.toSet(),
          equals({
            PitchClass.cNatural,
            PitchClass.dNatural,
            PitchClass.eNatural,
            PitchClass.fNatural,
            PitchClass.gNatural,
            PitchClass.aNatural,
            PitchClass.bNatural,
          }));
    });

    test('toList returns a list of pitch classes in the Scale', () {
      var scale = Scale.major(PitchClass.cNatural);
      expect(
          scale.toList(),
          equals([
            PitchClass.cNatural,
            PitchClass.dNatural,
            PitchClass.eNatural,
            PitchClass.fNatural,
            PitchClass.gNatural,
            PitchClass.aNatural,
            PitchClass.bNatural,
          ]));
    });

    test('[n] returns the PitchClass at the nth scale degree', () {
      var scale = Scale.major(PitchClass.cNatural);
      expect(scale[1], PitchClass.cNatural);
      expect(scale[2], PitchClass.dNatural);
      expect(scale[3], PitchClass.eNatural);
      expect(scale[4], PitchClass.fNatural);
      expect(scale[5], PitchClass.gNatural);
      expect(scale[6], PitchClass.aNatural);
      expect(scale[7], PitchClass.bNatural);
    });
  });

  group('Scale.mode(n)', () {
    test('creates a new Scale as the nth mode of the Scale', () {
      var cMajor = Scale.major(PitchClass.cNatural);
      var ionian = cMajor.mode(1);
      var dorian = cMajor.mode(2);
      var phrygian = cMajor.mode(3);
      var lydian = cMajor.mode(4);
      var mixolydian = cMajor.mode(5);
      var aeolian = cMajor.mode(6);
      var locrian = cMajor.mode(7);

      expect(ionian.identity, equals(cMajor.identity));
      expect(ionian.tonic.setNumber, equals(PitchClass.cNatural.setNumber));

      expect(dorian.identity, equals(1709));
      expect(dorian.tonic.setNumber, equals(PitchClass.dNatural.setNumber));

      expect(phrygian.identity, equals(1451));
      expect(phrygian.tonic.setNumber, equals(PitchClass.eNatural.setNumber));

      expect(lydian.identity, equals(2773));
      expect(lydian.tonic.setNumber, equals(PitchClass.fNatural.setNumber));

      expect(mixolydian.identity, equals(1717));
      expect(mixolydian.tonic.setNumber, equals(PitchClass.gNatural.setNumber));

      expect(aeolian.identity, equals(1453));
      expect(aeolian.tonic.setNumber, equals(PitchClass.aNatural.setNumber));

      expect(locrian.identity, equals(1387));
      expect(locrian.tonic.setNumber, equals(PitchClass.bNatural.setNumber));
    });
  });
}
