import 'package:vivace_core/src/pitch_class.dart';
import 'package:test/test.dart';

void main() {
  group('PitchClass', () {
    test('constructor sets the set number when created', () {
      var pc = PitchClass(1);
      expect(pc.setNumber, equals(1));
    });

    test('has named constructors for common pitch class names', () {
      expect(PitchClass.cNatural.setNumber, equals(0));
      expect(PitchClass.cSharp.setNumber, equals(1));
      expect(PitchClass.dFlat.setNumber, equals(1));
      expect(PitchClass.dNatural.setNumber, equals(2));
      expect(PitchClass.dSharp.setNumber, equals(3));
      expect(PitchClass.eFlat.setNumber, equals(3));
      expect(PitchClass.eNatural.setNumber, equals(4));
      expect(PitchClass.fNatural.setNumber, equals(5));
      expect(PitchClass.fSharp.setNumber, equals(6));
      expect(PitchClass.gFlat.setNumber, equals(6));
      expect(PitchClass.gNatural.setNumber, equals(7));
      expect(PitchClass.gSharp.setNumber, equals(8));
      expect(PitchClass.aFlat.setNumber, equals(8));
      expect(PitchClass.aNatural.setNumber, equals(9));
      expect(PitchClass.aSharp.setNumber, equals(10));
      expect(PitchClass.bFlat.setNumber, equals(10));
      expect(PitchClass.bNatural.setNumber, equals(11));
    });

    test('displays the set number when converted to a string', () {
      var pc = PitchClass(9);
      expect(pc.toString(), equals('PitchClass(${pc.setNumber})'));
    });

    test('can be added into a Set of unique pitch classes', () {
      var pcs = {PitchClass(1), PitchClass(5), PitchClass(4), PitchClass(1)};
      expect(pcs, equals({PitchClass(1), PitchClass(5), PitchClass(4)}));
    });

    test('can be sorted in a List', () {
      var pitchClasses = [PitchClass(4), PitchClass(7), PitchClass(3)];
      pitchClasses.sort();

      expect(
          pitchClasses, equals([PitchClass(3), PitchClass(4), PitchClass(7)]));
    });

    test('can be compared against other pitch classes', () {
      expect(PitchClass(0), lessThan(PitchClass(1)));
      expect(PitchClass(9), greaterThan(PitchClass(3)));
      expect(PitchClass(4), lessThanOrEqualTo(PitchClass(4)));
      expect(PitchClass(3), lessThanOrEqualTo(PitchClass(4)));
      expect(PitchClass(7), greaterThanOrEqualTo(PitchClass(7)));
      expect(PitchClass(8), greaterThanOrEqualTo(PitchClass(7)));
      expect(PitchClass(11), equals(PitchClass(11)));
    });
  });
}
