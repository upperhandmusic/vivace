/// Combination of note name and accidental (independent of octave).
class PitchClass implements Comparable<PitchClass> {
  static const cNatural = PitchClass(0);
  static const cSharp = PitchClass(1);
  static const dFlat = PitchClass(1);
  static const dNatural = PitchClass(2);
  static const dSharp = PitchClass(3);
  static const eFlat = PitchClass(3);
  static const eNatural = PitchClass(4);
  static const fNatural = PitchClass(5);
  static const fSharp = PitchClass(6);
  static const gFlat = PitchClass(6);
  static const gNatural = PitchClass(7);
  static const gSharp = PitchClass(8);
  static const aFlat = PitchClass(8);
  static const aNatural = PitchClass(9);
  static const aSharp = PitchClass(10);
  static const bFlat = PitchClass(10);
  static const bNatural = PitchClass(11);

  /// The set number of this pitch class (starting from 0).
  final int setNumber;

  const PitchClass(this.setNumber) : assert(setNumber >= 0 && setNumber <= 11);

  @override
  int get hashCode => setNumber.hashCode;

  @override
  String toString() {
    return 'PitchClass($setNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PitchClass && other.setNumber == setNumber;
  }

  bool operator <(PitchClass other) {
    return setNumber < other.setNumber;
  }

  bool operator <=(PitchClass other) {
    return setNumber <= other.setNumber;
  }

  bool operator >(PitchClass other) {
    return setNumber > other.setNumber;
  }

  bool operator >=(PitchClass other) {
    return setNumber >= other.setNumber;
  }

  @override
  int compareTo(PitchClass other) {
    if (setNumber > other.setNumber) return 1;
    if (setNumber < other.setNumber) return -1;
    return 0;
  }
}
