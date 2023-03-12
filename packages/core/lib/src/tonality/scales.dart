import 'package:meta/meta.dart';

import '../helpers/_binary.dart';
import '../pitch/pitch_class.dart';

/// A musical scale, an ordered set of pitches.
///
/// TODO: explain choices about scale representation
/// * octave independence (using PitchClass instead of Note)
/// * numeric ID (based on binary representation)
/// * stored as ascending form, descending is derived in getter
@immutable
class Scale {
  /// Creates a [Scale] starting on [tonic] and with the given [id].
  ///
  /// The [id] is a numeric identity for the scale from its binary
  /// representation, see [A Study of Scales](https://ianring.com/musictheory/scales/)
  /// for more detail.
  const Scale({required this.tonic, required this.id});

  /// Creates a minor pentatonic [Scale] starting from [tonic].
  ///
  /// See [Minor Pentatonic Scale](https://ianring.com/musictheory/scales/1193)
  /// for more detail.
  const Scale.minorPentatonic(this.tonic) : id = 1193;

  /// Creates a major pentatonic [Scale] starting from [tonic].
  ///
  /// See [Major Pentatonic Scale](https://ianring.com/musictheory/scales/661)
  /// for more detail.
  const Scale.majorPentatonic(this.tonic) : id = 661;

  /// Creates a wholetone [Scale] starting from [tonic].
  ///
  /// See [Whole Tone Scale](https://ianring.com/musictheory/scales/1365) for
  /// more detail.
  const Scale.wholetone(this.tonic) : id = 1365;

  /// Creates a blues [Scale] starting from [tonic].
  ///
  /// See [Blues Scale](https://ianring.com/musictheory/scales/1257) for more
  /// detail.
  const Scale.blues(this.tonic) : id = 1257;

  /// Creates a major [Scale] starting from [tonic].
  ///
  /// See [Major Scale](https://ianring.com/musictheory/scales/2741) for more
  /// detail.
  const Scale.major(this.tonic) : id = 2741;

  /// Creates a natural minor (aeolian) [Scale] starting from [tonic].
  ///
  /// See [Aeolian Scale](https://ianring.com/musictheory/scales/1453) for more
  /// detail.
  const Scale.naturalMinor(this.tonic) : id = 1453;

  /// Creates a melodic minor [Scale] starting from [tonic].
  ///
  /// See [Melodic Minor Scale](https://ianring.com/musictheory/scales/2733)
  /// for more detail.
  const Scale.melodicMinor(this.tonic) : id = 2733;

  /// Creates a harmonic minor [Scale] starting from [tonic].
  ///
  /// See [Harmonic Minor Scale](https://ianring.com/musictheory/scales/2477)
  /// for more detail.
  const Scale.harmonicMinor(this.tonic) : id = 2477;

  /// Creates a harmonic major [Scale] starting from [tonic].
  ///
  /// See [Harmonic Major Scale](https://ianring.com/musictheory/scales/2485)
  /// for more detail.
  const Scale.harmonicMajor(this.tonic) : id = 2485;

  /// Creates an octatonic (half-whole diminished) [Scale] starting from
  /// [tonic].
  ///
  /// See [Octatonic Scale](https://ianring.com/musictheory/scales/1755) for
  /// more detail.
  const Scale.octatonic(this.tonic) : id = 1755;

  /// Creates a chromatic [Scale] starting from [tonic].
  ///
  /// See [Chromatic Scale](https://ianring.com/musictheory/scales/4095) for
  /// more detail.
  const Scale.chromatic(this.tonic) : id = 4095;

  // TODO: make this work with a PitchClassSet instead because it's hard to
  // ensure that the input list of pitch classes is correct (min, max,
  // uniqueness)
  // A PitchClassSet value object can validate its inputs when constructed.
  Scale.fromList({required this.tonic, required List<int> pitchClasses})
      : id =
            pitchClasses.fold(0, (n, pitchClass) => n | pitchClass.asBitMask()),
        assert(
          pitchClasses.every((element) => element >= _lowestPitchClass),
          'All pitch classes must be >= $_lowestPitchClass',
        ),
        assert(
          pitchClasses.every((element) => element <= _highestPitchClass),
          'All pitch classes must be <= $_highestPitchClass',
        );

  /// The starting pitch class for the scale, for example "D#".
  final PitchClass tonic;

  /// The numeric identity of the scale from its binary representation, see
  /// https://ianring.com/musictheory/scales/ for more details.
  final int id;

  static const _lowestPitchClass = 0;

  static const _highestPitchClass = 11;

  /// The count of scale degrees in this [Scale].
  int get scaleDegreeCount => id.countEnabledBits();

  /// Get a scale mode starting on [scaleDegree].
  ///
  /// [scaleDegree] must be between 1 and [scaleDegreeCount], as is common
  /// when referring to modes in a musical setting.
  ///
  /// For example, given a major scale, mode 1 is the Ionian mode (the major
  /// scale itself), mode 2 is the dorian mode, etc.
  Scale mode(int scaleDegree) {
    assert(scaleDegree >= 1, 'scaleDeree must be >= to 1');
    assert(
      scaleDegree <= scaleDegreeCount,
      'scaleDeree must be <= to $scaleDegreeCount',
    );

    if (scaleDegree == 1) return Scale(tonic: tonic, id: id);

    final modeScaleDegree = id.enabledBits[scaleDegree - 1];
    final newIdentity = id.rotateRight(modeScaleDegree);
    final newTonic = PitchClass.at(modeScaleDegree);

    return Scale(tonic: newTonic, id: newIdentity);
  }

  Set<PitchClass> toSet() => id.enabledBits.map(PitchClass.at).toSet();

  List<PitchClass> toList() => id.enabledBits.map(PitchClass.at).toList();

  /// Returns the asecnding version of this [Scale].
  Set<PitchClass> get ascending => throw UnimplementedError();

  /// Returns the descending version of this [Scale].
  Set<PitchClass> get descending => throw UnimplementedError();

  /// Creates a copy of this [Scale] rotated left by [semitoneCount] semitones.
  Set<PitchClass> rotateLeft(int semitoneCount) => throw UnimplementedError();

  /// Creates a copy of this [Scale] rotated right by [semitoneCount] semitones.
  Set<PitchClass> rotateRight(int semitoneCount) => throw UnimplementedError();

  /// Returns the [PitchClass] at index of [scaleDegree].
  ///
  /// [scaleDegree] must be between 1 and [scaleDegreeCount], as is common
  /// when referring to scale degrees in a musical setting.
  PitchClass operator [](int scaleDegree) {
    assert(scaleDegree >= 1, 'scaleDeree must be >= to 1');
    assert(
      scaleDegree <= scaleDegreeCount,
      'scaleDeree must be <= to $scaleDegreeCount',
    );
    return toList().elementAt(scaleDegree - 1);
  }
}
