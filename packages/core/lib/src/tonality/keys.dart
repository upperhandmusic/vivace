import 'chords.dart';
import 'intervals.dart';
import 'scales.dart';

enum HarmonicFunction {
  /// I, VI
  tonic,

  /// II, bII, IV,
  predominant,

  /// III, V, VII
  dominant,
  // tonic,
  // supertonic,
  // mediant,
  // subdominant,
  // dominant,
  // submediant,
  // subtonic,
  // leading,
}

class KeySignature {
  // TODO: figure out how to represent this properly
  // Maybe Set<Note>
  //
}

class Key {
  KeySignature get signature {
    throw UnimplementedError();
  }

  List<Chord> get tonicChords {
    throw UnimplementedError();
  }

  List<Chord> get predominantChords {
    throw UnimplementedError();
  }

  List<Chord> get dominantChords {
    throw UnimplementedError();
  }

  // Key(this.id);

  // TODO: related keys
  // ii (supertonic, the relative minor of the subdominant)
  // iii (mediant, the relative minor of the dominant)
  // IV (subdominant): one less sharp (or one more flat) around circle of fifths
  // V (dominant): one more sharp (or one fewer flat) around circle of fifths
  // vi (submediant or relative minor): different tonic, same key signature
  // i (parallel minor): same tonic, different key signature
  //
  // order of closeness (by number of different notes in key):
  // 0 notes (relative minor): vi
  // 1 note (diatonic): ii, iii, IV, V
  // 2 notes (secondary subdominants): bII, bIII, bVI, bVII
  // 3 notes (secondary dominants): II, III, VI, VII
  // 3 notes (parallel minor):
  //
  // Starting from a minor key (i), the closely related keys are
  // III (the mediant or relative major)
  // iv (the subdominant)
  // v (the minor dominant)
  // VI (the submediant)
  // VII (the subtonic)
  // I (the parallel major)

  /// major or minor (does this need to account for weird stuff like Bartok
  /// key signatures?)
  String get quality {
    throw UnimplementedError();
  }

  /// Returns the relative minor key for a major key or the relative major key
  /// for a minor key.
  Key get relative {
    throw UnimplementedError();
  }

  /// Returns parallel minor key for a major key or the parallel major key for a
  /// minor key.
  Key get parallel {
    // TODO: implement parallel key getter
    // if (this.quality == KeyQuality.major)
    //
    throw UnimplementedError();
  }

  Set<Chord> get chords {
    throw UnimplementedError();
  }

  Scale scale([int scaleDegree = 1]) {
    throw UnimplementedError();
  }

  Set<Scale> scales() {
    // return Set.unmodifiable([scale1, scale2, etc.])
    throw UnimplementedError();
  }

  Chord secondaryDominant(int scaleDegree) {
    throw UnimplementedError();
  }

  // TODO: does this make sense with pitch classes or should it be specific
  // to a note spelling since we're dealing with functional harmony?
  // Set<PitchClass> get commonTones {}

  // TODO: better name (proximityTo?, affinity)
  // check how many tones are different between this key and another
  // int affinity(Key other) {}

  // where adjustment is an Interval or an int (semitones)
  Key transpose(Object adjustment) {
    if (adjustment is Interval) {
      // TODO: return new Key that is Interval away
      throw UnimplementedError();
    }

    if (adjustment is int) {
      // TODO: return new Key that is int semitones away
      throw UnimplementedError();
    }

    throw ArgumentError.value(
      adjustment,
      'adjustment',
      'must be either a type of Interval or int',
    );
  }
}
