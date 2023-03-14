import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../../pitch.dart';
import '../helpers/_binary.dart';
import '../pitch/pitch_class.dart';

/// A musical scale, an ordered set of pitches.
///
/// TODO: explain choices about scale representation
/// * octave independence (using PitchClass instead of Note)
/// * numeric ID (based on binary representation)
/// * stored as ascending form, descending is derived in getter
/// * iterable so you can filter, check if it contains a pitch class, etc.
@immutable
class Scale with IterableMixin<PitchClass> {
  // TODO: implement equality to check scale by ids and tonics (or just by
  // ids)?

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
  // TODO: better validation logic -- must be ordered and starts with lowest
  // PitchClass which is assumed to be the tonic.
  factory Scale.from(Iterable<int> pitchClasses) {
    final sanitized = pitchClasses.sorted((a, b) => a.compareTo(b)).toSet();
    final tonic = PitchClass.at(sanitized.first);
    final id = sanitized.fold(0, (n, pitchClass) => n | pitchClass.asBitMask());
    return Scale(tonic: tonic, id: id);
  }

  /// The starting pitch class for the scale, for example "D#".
  final PitchClass tonic;

  /// The numeric identity of the scale from its binary representation, see
  /// https://ianring.com/musictheory/scales/ for more details.
  final int id;

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

  /// Returns the asecnding version of this [Scale].
  Set<PitchClass> get ascending => Set.unmodifiable(this);

  /// Returns the descending version of this [Scale].
  Set<PitchClass> get descending => Set.unmodifiable(toList().reversed);

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
    return elementAt(scaleDegree - 1);
  }

  @override
  Iterator<PitchClass> get iterator => ScaleIterator(id);
}

class ScaleIterator implements Iterator<PitchClass> {
  ScaleIterator(this._scaleId);

  int _scaleId;

  int _position = -1;

  @override
  PitchClass get current {
    if (_position < 0) {
      throw StateError('Cannot get current pitch class from scale');
    }
    return PitchClass.at(_position);
  }

  @override
  bool moveNext() {
    while (_scaleId > 0) {
      final hasPitchAtCurrentPosition = _scaleId.isFirstBitEnabled();
      _position += 1;
      _scaleId >>>= 1;
      if (hasPitchAtCurrentPosition) return true;
    }

    _position = -1;

    return false;
  }
}
