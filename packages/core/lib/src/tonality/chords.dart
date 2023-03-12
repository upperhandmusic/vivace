import '../pitch/pitch.dart';

enum ChordQuality {
  diminished,
  minor,
  major,
  suspended,
  augmented,
}

class Chord {
  Chord({required this.pitches});

  final Set<Pitch> pitches;

  ChordQuality get quality => throw UnimplementedError();
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
