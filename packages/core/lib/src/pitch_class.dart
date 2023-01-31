/// Combination of note name and accidental (independent of octave).
enum PitchClass implements Comparable<PitchClass> {
  C,
  // ignore: constant_identifier_names
  Db,
  D,
  // ignore: constant_identifier_names
  Eb,
  E,
  F,
  // ignore: constant_identifier_names
  Gb,
  G,
  // ignore: constant_identifier_names
  Ab,
  A,
  // ignore: constant_identifier_names
  Bb,
  B;

  factory PitchClass.from(int setNumber) =>
      PitchClass.values.elementAt(setNumber);

  get setNumber => index;

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
