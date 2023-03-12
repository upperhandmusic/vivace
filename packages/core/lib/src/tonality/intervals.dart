enum Interval {
  unison(0),
  minorSecond(1),
  majorSecond(2),
  minorThird(3),
  majorThird(4),
  perfectFourth(5),
  tritone(6),
  perfectFifth(7),
  minorSixth(8),
  majorSixth(9),
  minorSeventh(10),
  majorSeventh(11),
  octave(0);

  const Interval(this.semitones);

  factory Interval.from(int semitones) =>
      Interval.values.elementAt(semitones % 12);

  final int semitones;

  String get abbreviation => Interval._names[semitones]['short']!;

  String get name => Interval._names[semitones]['long']!;

  // TODO: deal with tonal intervals like augmented and diminished

  @override
  String toString() => name;

  static const _names = [
    {'short': 'P1', 'long': 'Unison'},
    {'short': 'm2', 'long': 'Minor 2nd'},
    {'short': 'M2', 'long': 'Major 2nd'},
    {'short': 'm3', 'long': 'Minor 3rd'},
    {'short': 'M3', 'long': 'Major 3rd'},
    {'short': 'P4', 'long': 'Perfect 4th'},
    {'short': 'TT', 'long': 'Tritone'},
    {'short': 'P5', 'long': 'Perfect 5th'},
    {'short': 'm6', 'long': 'Minor 6th'},
    {'short': 'M6', 'long': 'Major 6th'},
    {'short': 'm7', 'long': 'Minor 7th'},
    {'short': 'M7', 'long': 'Major 7th'},
    {'short': 'P8', 'long': 'Octave'},
  ];
}

// Interval.between(Note a, Note b);
