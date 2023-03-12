import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../helpers/_equivalence.dart';
import '../pitch/pitch_class.dart';

/// An auditory attribute of sound according to which sounds can be ordered on
/// a scale from low to high. Each distinct [Pitch] is the combination of
/// a [PitchClass] and [Octave].
@immutable
class Pitch with EquatableMixin, Comparability<Pitch> {
  /// Creates a [Pitch] with the given [pitchClass] and [octave].
  const Pitch({required this.pitchClass, required this.octave});

  /// Create a [Pitch] from a text name, such as C-1, Ab4 or D#7.
  factory Pitch.named(String text) {
    final pattern = RegExp(
      r'(?<noteName>[A-G][#b]?)(?<octave>-?\d{1,2})',
      caseSensitive: false,
    );
    final match = pattern.firstMatch(text);
    final noteName = match?.namedGroup('noteName') ?? '';

    try {
      final octaveNumber = int.parse(match?.namedGroup('octave') ?? '');
      return Pitch(
        pitchClass: PitchClass.named(noteName),
        octave: Octave(octaveNumber),
      );
    } on FormatException {
      throw ArgumentError.value(text, 'octave', 'must be an integer');
    }
  }

  final PitchClass pitchClass;
  final Octave octave;

  @override
  List<Object> get props => [octave, pitchClass];

  @override
  bool operator <(Pitch other) {
    if (octave < other.octave) return true;
    if (octave > other.octave) return false;
    return pitchClass < other.pitchClass;
  }

  @override
  bool operator <=(Pitch other) {
    if (octave < other.octave) return true;
    if (octave > other.octave) return false;
    return pitchClass <= other.pitchClass;
  }

  @override
  bool operator >(Pitch other) {
    if (octave < other.octave) return false;
    if (octave > other.octave) return true;
    return pitchClass > other.pitchClass;
  }

  @override
  bool operator >=(Pitch other) {
    if (octave < other.octave) return false;
    if (octave > other.octave) return true;
    return pitchClass >= other.pitchClass;
  }

  Pitch operator +(int semitones) {
    final octaves = (semitones / NoteName.values.length).floor();
    return Pitch(pitchClass: pitchClass + semitones, octave: octave + octaves);
  }

  Pitch operator -(int semitones) => throw UnimplementedError();

  // Frequency toFrequency() => throw UnimplementedError();

  Pitch transpose(int steps) => throw UnimplementedError();
}

@immutable
class Octave with EquatableMixin, Comparability<Octave> {
  const Octave(this.number)
      : assert(
          number >= _lowest,
          'octave number must be greater than or equal to $_lowest',
        ),
        assert(
          number <= _highest,
          'octave number must be less than or equal to $_highest',
        );
  static const int _lowest = -1;

  static const int _highest = 10;

  final int number;

  Octave get lowest => const Octave(_lowest);

  Octave get highest => const Octave(_highest);

  @override
  bool operator <(Octave other) => number < other.number;

  @override
  bool operator <=(Octave other) => number <= other.number;

  @override
  bool operator >(Octave other) => number > other.number;

  @override
  bool operator >=(Octave other) => number >= other.number;

  Octave operator +(int octaves) => Octave(number + octaves);

  Octave operator -(int octaves) => Octave(number - octaves);

  @override
  List<Object> get props => [number];
}
