import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../helpers/_equivalence.dart';
import '../pitch/pitch_class.dart';

/// An auditory attribute of sound according to which sounds can be ordered on
/// a scale from low to high. Each distinct [Pitch] is the combination of
/// a [PitchClass] and octave number.
@immutable
class Pitch with EquatableMixin, Comparability<Pitch> {
  /// Creates a [Pitch] from the given [midiNoteNumber].
  const Pitch(int midiNoteNumber) : noteNumber = midiNoteNumber;

  /// Create a [Pitch] from a text name, such as C-1, Ab4 or D#7.
  factory Pitch.named(String text) {
    final pattern = RegExp(
      r'(?<noteName>[A-G][#b]?)(?<octave>-?\d{1,2})',
      caseSensitive: false,
    );
    final match = pattern.firstMatch(text);
    final noteName = match?.namedGroup('noteName') ?? '';

    try {
      final pitchClass = PitchClass.named(noteName);
      final octaveNumber = int.parse(match?.namedGroup('octave') ?? '');
      return Pitch.from(pitchClass: pitchClass, octave: octaveNumber);
    } on FormatException {
      throw ArgumentError.value(text, 'octave', 'must be an integer');
    }
  }

  /// Creates a [Pitch] with the given [pitchClass] and [octave].
  ///
  /// The [octave] values conform to the Roland MIDI standard, where C4 (the
  /// pitch class C in the 4th octave) is equivalent to middle C. This means the
  /// value of [octave] must be between -1 and 9.
  factory Pitch.from({required PitchClass pitchClass, required int octave}) {
    assert(octave >= -1 && octave <= 9, 'Octave must be between -1 and 9');
    return Pitch((octave + 1) * 12 + pitchClass.setNumber);
  }

  /// The MIDI note number that represents this [Pitch].
  final int noteNumber;

  /// The [PitchClass] of this [Pitch].
  PitchClass get pitchClass => PitchClass.at(noteNumber % 12);

  /// The octave of this [Pitch].
  int get octave => (noteNumber / 12).floor();

  @override
  List<Object> get props => [noteNumber];

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

  /// Increment this [Pitch] by the given number of [semitones].
  Pitch operator +(int semitones) => Pitch(noteNumber + semitones);

  /// Decrement this [Pitch] by the given number of [semitones].
  Pitch operator -(int semitones) => Pitch(noteNumber - semitones);

  /// Transpose this [Pitch] by the given number of [steps].
  ///
  /// Example:
  ///
  /// ```dart
  /// final c4 = Pitch(60);
  /// c4.transpose(2); // => Pitch(62)
  /// c4.transpose(-2); // => Pitch(58)
  /// ```
  Pitch transpose(int steps) => steps >= 0 ? this + steps : this - steps;

  // Frequency toFrequency() => throw UnimplementedError();
}
