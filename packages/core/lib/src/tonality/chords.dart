import '../pitch/pitch.dart';

enum ChordQuality {
  diminished,
  minor,
  major,
  suspended,
  augmented,
}

/// A chord is a set of pitches that are played together.
///
/// ```dart
/// const cMajorTriad = Chord({ Pitch(60), Pitch(64), Pitch(67)) });
/// const cMajorTriadSpread = Chord({ Pitch(60), Pitch(67), Pitch(76)) });
/// ```
class Chord {
  Chord(this.pitches);

  // Chord.from(ChordQuality quality, Pitch startingOn, {int inversion = 0});

  final Set<Pitch> pitches;

  ChordQuality get quality => throw UnimplementedError();

  /// The root of the chord.
  PitchClass get root => throw UnimplementedError();

  /// The inversion of the chord given as the number in the cycle of possible
  ///
  /// Example:
  /// ```dart
  /// final triad = Chord({PitchClass.F, PitchClass.Bb, PitchClass.D});
  /// triad.inversion(0); // => Chord({PitchClass.F, PitchClass.Bb, PitchClass.D});
  /// triad.inversion(1); // => Chord({PitchClass.Bb, PitchClass.D, PitchClass.F});
  /// triad.inversion(2); // => Chord({PitchClass.D, PitchClass.F, PitchClass.Bb});
  /// ```
  Chord get inversion => throw UnimplementedError();

  /// The inversion of the chord given as the number in the cycle of possible
  /// chord inversions. For example, if the chord is a triad, there are three
  /// possible inversions: root position, first inversion, and second inversion,
  /// and those inversions would be represented by 0, 1, and 2 respectively.
  ///
  /// Example:
  /// ```dart
  /// final triad = Chord({PitchClass.F, PitchClass.Bb, PitchClass.D});
  /// triad.inversion(0); // => Chord({PitchClass.F, PitchClass.Bb, PitchClass.D});
  /// triad.inversion(1); // => Chord({PitchClass.Bb, PitchClass.D, PitchClass.F});
  /// triad.inversion(2); // => Chord({PitchClass.D, PitchClass.F, PitchClass.Bb});
  /// ```
  Chord inversion(int inversion) => throw UnimplementedError();
}

// var F = Note.fNatural(4);
// var Bb = Note.bFlat(5);
// var D = Note.dNatural(5);
// var chord = Chord.from({F, Bb, D})
// chord.inversion //=> Inversion.second how can you tell what the chord is though?

// var chord = Chord(startingOn: PitchClass.dNatural,
//                  quality: ChordQuality.major);
// chord.notes; // {PitchClass(2), PitchClass(6), PitchClass(9)}
// chord.transpose(5);

// var chord = Chord(startingOn: PitchClass.dNatural,
//    quality: ChordQuality.major,
//    extensions: [ChordExtensions.majorSeventh, ChordExtensions.eleventh]);
