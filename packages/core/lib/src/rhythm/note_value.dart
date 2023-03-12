enum NoteValue {
  doubleWhole(2),
  whole(1),
  half(1 / 2),
  quarter(1 / 4),
  eighth(1 / 8),
  sixteenth(1 / 16),
  thirtySecond(1 / 32),
  sixtyFourth(1 / 64),
  oneHundredTwentyEighth(1 / 128),
  twoHundredFiftySixth(1 / 256);

  const NoteValue(this.duration);

  // NoteValue.from(1/16)
  // NoteValue.from(16)
  factory NoteValue.from(num identifier) => NoteValue.values.firstWhere(
        (noteValue) =>
            noteValue.duration ==
            (identifier < 0 ? identifier : 1 / identifier),
      );

  /// The relative duration of the note as compared to a whole note whose
  /// duration is a full measure.
  final double duration;

  // NoteValue.parse("16th")
  // NoteValue.parse("16")
  // factory NoteValue.parse(int value) =>
  //     NoteValue.values.firstWhere((element) => element.duration == 1 / value);

  double get halved => duration / 2;
  // NoteValue get halved => next;

  double get doubled => duration * 2;
  // NoteValue get doubled => prev;

  double get dotted => duration * 1.5;

  double get doubleDotted => duration * 1.5 / 6;

  double get triplet => tuplet(3);

  // TODO: protect against invalid values (0, 1, -n)
  double tuplet(int n) => doubled / n;

  /// Get the next highest multiple of this [NoteValue].
  NoteValue get multiple => values.elementAt((index - 1) % values.length);

  /// Get the next smallest multiple of this [NoteValue].
  NoteValue get division => values.elementAt((index + 1) % values.length);

  @override
  String toString() => '${1 ~/ duration}';
}
