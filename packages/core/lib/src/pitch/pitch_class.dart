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

  /// Creates a [PitchClass] from the given [setNumber].
  factory PitchClass.at(int setNumber) =>
      PitchClass.values.elementAt(setNumber);

  factory PitchClass.from(NoteName noteName, Accidental accidental) {
    final natualNotePitchClass = PitchClass.values.byName(noteName.name);

    switch (accidental) {
      case Accidental.sharp:
        return PitchClass.values.byName(noteName.name).next;
      case Accidental.flat:
        return PitchClass.values.byName(noteName.name).prev;
      default:
        return natualNotePitchClass;
    }
  }

  /// Creates a [PitchClass] from the given note [name], such as E, C# or Ab.
  ///
  /// ```dart
  /// assert(PitchClass.named('C'), PitchClass.C);
  /// assert(PitchClass.named('D#'), PitchClass.Eb)
  /// assert(PitchClass.named('Eb'), PitchClass.Eb);
  /// ```
  factory PitchClass.named(String name) {
    final pattern = RegExp(
      r'^(?<noteName>[A-G])(?<accidental>[b#]?)$',
    );
    final match = pattern.firstMatch(name);

    if (match == null) {
      throw ArgumentError.value(name, 'name', 'No matching pitch class found');
    }

    final noteName = NoteName.from(match.namedGroup('noteName') ?? '');
    final accidental = Accidental.from(match.namedGroup('accidental') ?? '');

    return PitchClass.from(noteName, accidental);
  }

  int get setNumber => index;

  bool operator <(PitchClass other) => setNumber < other.setNumber;

  bool operator <=(PitchClass other) => setNumber <= other.setNumber;

  bool operator >(PitchClass other) => setNumber > other.setNumber;

  bool operator >=(PitchClass other) => setNumber >= other.setNumber;

  PitchClass operator +(int semitones) {
    final newSetNumber = (setNumber + semitones) % values.length;
    return PitchClass.at(newSetNumber);
  }

  PitchClass operator -(int semitones) {
    final newSetNumber = (setNumber - semitones) % values.length;
    return PitchClass.at(newSetNumber);
  }

  PitchClass get prev =>
      PitchClass.values.elementAt((index - 1) % values.length);

  PitchClass get next =>
      PitchClass.values.elementAt((index + 1) % values.length);

  @override
  int compareTo(PitchClass other) {
    if (setNumber > other.setNumber) return 1;
    if (setNumber < other.setNumber) return -1;
    return 0;
  }
}

enum NoteName {
  C,
  D,
  E,
  F,
  G,
  A,
  B;

  /// Creates a [NoteName] from the given text [name].
  factory NoteName.from(String name) => NoteName.values.byName(name);

  NoteName get prev => NoteName.values.elementAt((index - 1) % values.length);

  NoteName get next => NoteName.values.elementAt((index + 1) % values.length);
}

enum Accidental {
  flat,
  natural,
  sharp;

  const Accidental();

  /// Creates an [Accidental] from the provided [descriptor].
  ///
  /// ```dart
  /// assert(Accidental.from(''), Accidental.natural);
  /// assert(Accidental.from('b'), Accidental.flat);
  /// assert(Accidental.from('#'), Accidental.sharp);
  /// ```
  factory Accidental.from(String descriptor) {
    switch (descriptor) {
      case 'b':
        return Accidental.flat;
      case '#':
        return Accidental.sharp;
      case '':
        return Accidental.natural;
      default:
        throw ArgumentError.value(descriptor, 'descriptor');
    }
  }

  String get symbol {
    switch (this) {
      case flat:
        return '♭';
      case sharp:
        return '♯';
      default:
        return '♮';
    }
  }

  Accidental get prev =>
      Accidental.values.elementAt((index - 1) % values.length);

  Accidental get next =>
      Accidental.values.elementAt((index + 1) % values.length);
}
