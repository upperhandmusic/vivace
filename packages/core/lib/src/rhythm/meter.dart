import './note_value.dart';
import '../helpers/_binary.dart';

/// Compound meters are written with a time signature that shows the number of
/// divisions of beats in each bar as opposed to the number of beats.
///
/// The top number of a time signature in compound meter expresses the number of
/// divisions in a measure, while the bottom number expresses the division unit—which note value is the division.
/// In compound meters, the top number is always a multiple of three
enum MeterClassification {
  simple,
  compound,
  complex,
}

/// Represents the organization of regularly recurring beats and accents in
/// music. See [Metre](https://en.wikipedia.org/wiki/Metre_(music)) for more
/// information.
///
/// Metric values are stored internally as integers, based on their binary
/// representation.
///
/// Example of binary beat representations:
/// 10 - 1/1, 1/2, 1/4, etc. (1 beat, 2 divisions)
/// 1010 - 2/1, 2/2, 2/4, etc. (2 beats, 4 divisions)
/// 101010 - 3/1, 3/2, 3/4, etc. (3 beats, 6 divisions)
/// 100100 - 6/4, 6/8, etc. (2 beats, 6 divisions)
/// 10101010 - 4/1, 4/2, 4/4, etc. (4 beats, 8 divisions)
/// 10010 or 10100 - 5/4, 5/8, etc. (2 beats, 5 divisions)
/// 1010100 or 1001010 or 1010010 - 7/4, 7/8, etc. (3 beats, 7 divisions)
/// 10010010 or 10100100 - 8/4, 8/8, etc. (3 beats, 8 divisions)
/// 100100100100 - 12/4, 12/8, etc. (4 beats, 12 divisions)
class Meter {
  /// 2/X meter == 1010 (binary) == 10 (decimal)
  static const _simpleDupleValue = 10;

  /// 3/X meter == 101010 (binary) == 42 (decimal)
  static const _simpleTripleValue = 42;

  /// 3/X meter == 101010 (binary) == 42 (decimal)
  static const _simpleQuadrupleValue = 170;

  /// 6/X meter == 100100 (binary) == 36 (decimal)
  static const _compoundDupleValue = 36;

  /// 9/X meter == 100100100 (binary) == 292 decimal
  static const _compoundTripleValue = 292;

  /// 12/X meter == 100100100100 (binary) == 2340 (decimal)
  static const _compoundQuadrupleValue = 2340;

  /// The note value of each beat, for example, a quarter note.
  final NoteValue noteValue;

  /// The numeric value of the meter, as represented in binary form. For example,
  /// a 4/4 meter would be 10101010 where each 1 represents a beat and there are
  /// 8 beat divisions in the cycle. This enables differentiation between
  /// simple and compound meters, for example, since there are two divisions per
  /// beat vs three (as in 12/8 whose representation would be 100100100100).
  /// It also allows a unique numeric represention of different accent patterns
  /// for meter with the same number of divisions per cycle. For example, 7/8
  /// can be represented as either 1010100 or 1001010, which are unique numbers.
  /// Therefore, it is possible to compare these against one another and know
  /// that they have the same number of beats per cycle, the same number of
  /// divisions per cycle, but since they are different numbers, they are not
  /// equivalent since the beats (pulses) occur at different places in the cycle.
  final int id;

  const Meter._(this.id, this.noteValue) : assert(id > 0);

  const Meter.simpleDuple([NoteValue noteValue = NoteValue.quarter])
      : this._(_simpleDupleValue, noteValue);

  const Meter.simpleTriple([NoteValue noteValue = NoteValue.quarter])
      : this._(_simpleTripleValue, noteValue);

  const Meter.simpleQuadruple([NoteValue noteValue = NoteValue.quarter])
      : this._(_simpleQuadrupleValue, noteValue);

  const Meter.compoundDuple([NoteValue noteValue = NoteValue.quarter])
      : this._(_compoundDupleValue, noteValue);

  const Meter.compoundTriple([NoteValue noteValue = NoteValue.quarter])
      : this._(_compoundTripleValue, noteValue);

  const Meter.compoundQuadruple([NoteValue noteValue = NoteValue.quarter])
      : this._(_compoundQuadrupleValue, noteValue);

  /// Creates a new meter from the given [metricStructure], a representation
  /// of meter in terms of beats and beat divisions in a single metric cycle.
  /// A value of 1 represents a beat and a value of 0 represents an unaccented
  /// division between beats.
  ///
  /// You can create common meters such as 4/4 or 6/8 as in the example
  /// below:
  ///
  /// ```dart
  /// final fourFour = Meter.fromList([1, 0, 1, 0, 1, 0, 1, 0]);
  /// final sixEight = Meter.fromList([1, 0, 0, 1, 0, 0], NoteValue.eighth);
  /// ```
  ///
  /// A [noteValue] can also be provided to change the meaning of what note
  /// value each beat represents. In compound and complex meters, such as 6/8
  /// or 7/8, this represents the note value of the divisions rather than the beat.
  ///
  /// Below is an example of creating a 2/2 meter:
  ///
  /// ```dart
  /// final twoTwo = Meter.fromList([1, 0, 1, 0], NoteValue.half);
  /// ```
  factory Meter.fromList(List<int> metricStructure,
      [NoteValue noteValue = NoteValue.quarter]) {
    final meterId = metricStructure.toBinary();
    return Meter._(meterId, noteValue);
  }

  /// Creates a new meter from the given [metricStructure], a representation
  /// of meter in terms of beats and beat divisions in a single metric cycle.
  /// A value of 1 represents a beat and a value of 0 represents an unaccented
  /// division between beats.
  ///
  /// You can create common meters such as 4/4 or 6/8 as in the example
  /// below:
  ///
  /// ```dart
  /// final fourFour = Meter.fromString('10101010');
  /// final sixEight = Meter.fromString('100100', NoteValue.eighth);
  /// ```
  ///
  /// A [noteValue] can also be provided to change the meaning of what note
  /// value each beat represents. In compound and complex meters, such as 6/8
  /// or 7/8, this represents the note value of the divisions rather than the beat.
  ///
  /// Below is an example of creating a 2/2 meter:
  ///
  /// ```dart
  /// final twoTwo = Meter.fromString('1010', NoteValue.half);
  /// ```
  factory Meter.fromString(String metricStructure,
      [NoteValue noteValue = NoteValue.quarter]) {
    final meterId = int.parse(metricStructure, radix: 2);
    return Meter._(meterId, noteValue);
  }

  /// The number of beats between the strongest recurring accented beat.
  int get beatsPerCycle => id.countEnabledBits();

  /// The number of note value divisions occuring within one metric cycle
  /// (typically a measure of music).
  int get divisionsPerCycle => id.countBits();

  MeterClassification get classification {
    final beatDivisions = divisionsPerCycle / beatsPerCycle;

    // 2 divisions per beat is simple meter, such as 4/4
    if (beatDivisions == 2) {
      return MeterClassification.simple;
    }

    // 3 divisions per beat is compound meter, such as 6/8
    if (beatDivisions == 3) {
      return MeterClassification.compound;
    }

    // ratios that are not 2 or 3 are complex meters, such as 7/8
    return MeterClassification.complex;
  }

  @override
  String toString() {
    switch (classification) {
      case MeterClassification.simple:
        return '$beatsPerCycle/$noteValue';
      default:
        return '$divisionsPerCycle/$noteValue';
    }
  }
}
