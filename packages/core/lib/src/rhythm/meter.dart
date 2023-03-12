import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './note_value.dart';
import '../helpers/_binary.dart';

/// Compound meters are written with a time signature that shows the number of
/// divisions of beats in each bar as opposed to the number of beats.
///
/// The top number of a time signature in compound meter expresses the number of
/// divisions in a measure, while the bottom number expresses the division unit
/// --which note value is the division.
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
@immutable
class Meter with EquatableMixin {
  /// Creates a new [Meter] from the given beat [count], note [value] and
  /// optional beat [grouping].
  ///
  /// Creates a [Meter] from the given metric structure. The metric structure
  /// is a list of integers where each position in the list represents an
  /// accented beat or division in the metric cycle and the value of each
  /// integer represents the number of beats or divisions between each accented
  /// beat. This differs depending on whether the type of meter is simple or
  /// compound / complex. See the provided examples.
  ///
  /// The sum of values in the list is equivalent to the total number of
  /// beats (simple meters) or divisions (compound / complex meters) in a single
  /// metric cycle.
  ///
  /// **Example: Simple Meter**
  ///
  /// ```dart
  /// final fourFour = Meter(4, NoteValue.quarter);
  /// ```
  ///
  /// This represents a 4/4 meter where beat 1 is accented and pulses occur 4
  /// times in a cycle.
  ///
  /// ```
  /// | x . . . | x . . . | etc.
  /// ```
  ///
  /// **Example: Compound Meter**
  ///
  /// ```dart
  /// final sixEight = Meter(6, NoteValue.eighth);
  /// ```
  ///
  /// This represents a 6/8 meter where beats 1 and 4 are accented, and pulses
  /// occur 6 times in a cycle.
  ///
  /// ```
  /// | x . . x . . | x . . x . . | etc.
  /// ```
  ///
  /// **Example: Complex Meter**
  ///
  /// ```dart
  /// final sevenEight = Meter(7, NoteValue.eighth);
  /// final sevenEightCustomGrouping = Meter(7, NoteValue.eighth,
  ///                                       grouping: [2, 3, 2]);
  ///
  /// ```
  /// This represents a 7/8 meter where beats 1, 4, and 6 are accented, and
  /// pulses occur 7 times in a cycle.
  ///
  /// ```
  /// | x . . x . x . | x . . x . x . | etc.
  /// ```
  Meter(int count, this.value, {List<int>? grouping})
      : id = _createId(count, grouping);

  /// Creates a new [Meter] from the provided text representation. The format
  /// must be a [String] indicating a time signature, such as `3/4`, which will
  /// automatically compute the beat groupings, or an additive signature like
  /// `3+2/8`, where you provide the beat groupings explicitly in the upper
  /// half of the signature.
  ///
  /// **Examples**
  ///
  /// ```dart
  /// final threeFour = Meter.parse('3/4');
  /// final sixEight = Meter.parse('6 / 8');
  /// final sevenEight = Meter.parse('2+3+2/8');
  /// final fiveEight = Meter.parse('3 + 2 / 8');
  /// ```
  factory Meter.parse(String text) {
    final parts = text.split('/');

    if (parts.length != 2) {
      throw ArgumentError.value(text, 'text', 'must be in format n/m');
    }

    final upper = parts.first.split('+').map(int.parse).toList();
    final noteValue = NoteValue.from(int.parse(parts.last));
    final beats = upper.length == 1 ? upper.first : upper.sum;
    final grouping = upper.length > 1 ? upper : null;

    return Meter(beats, noteValue, grouping: grouping);
  }

  /// Creates a new [Meter] in cut time (2/2).
  const Meter.cutTime() : this.simpleDuple(NoteValue.half);

  /// Creates a new [Meter] in common time (4/4).
  const Meter.commonTime() : this.simpleQuadruple();

  /// Creates a new [Meter] in compound quadruple time (12/X). Defaults to an
  /// eighth note value, a 12/8 meter.
  const Meter.compoundQuadruple([NoteValue value = NoteValue.eighth])
      : this._(_compoundQuadrupleId, value);

  /// Creates a new [Meter] in compound triple time (9/X). Defaults to an eighth
  /// note value, a 9/8 meter.
  const Meter.compoundTriple([NoteValue value = NoteValue.eighth])
      : this._(_compoundTriple, value);

  /// Creates a new [Meter] in compound duple time (6/X). Defaults to an eighth
  /// note value, a 6/8 meter.
  const Meter.compoundDuple([NoteValue value = NoteValue.eighth])
      : this._(_compoundDupleId, value);

  /// Creates a new [Meter] in simple quadruple time (4/X). Defaults to a quarter
  /// note value, a 4/4 meter.
  const Meter.simpleQuadruple([NoteValue value = NoteValue.quarter])
      : this._(_simpleQuadrupleId, value);

  /// Creates a new [Meter] in simple triple time (3/X). Defaults to a quarter
  /// note value, a 3/4 meter.
  const Meter.simpleTriple([NoteValue value = NoteValue.quarter])
      : this._(_simpleTripleId, value);

  /// Creates a new [Meter] in simple duple time (2/X). Defaults to a quarter
  /// note value, a 2/4 meter.
  const Meter.simpleDuple([NoteValue value = NoteValue.quarter])
      : this._(_simpleDupleId, value);

  const Meter._(this.id, this.value);

  /// 2/X meter == 1010 (binary) == 10 (decimal)
  static const _simpleDupleId = 10;

  /// 3/X meter == 101010 (binary) == 42 (decimal)
  static const _simpleTripleId = 42;

  /// 3/X meter == 101010 (binary) == 42 (decimal)
  static const _simpleQuadrupleId = 170;

  /// 6/X meter == 100100 (binary) == 36 (decimal)
  static const _compoundDupleId = 36;

  /// 9/X meter == 100100100 (binary) == 292 decimal
  static const _compoundTriple = 292;

  /// 12/X meter == 100100100100 (binary) == 2340 (decimal)
  static const _compoundQuadrupleId = 2340;

  /// The numeric value of the meter, as represented in binary form. For
  /// example, a 4/4 meter would be 10101010 where each 1 represents a beat and
  /// there are 8 beat divisions in the cycle. This enables differentiation
  /// between simple and compound meters, for example, since there are two
  /// divisions per beat vs three (as in 12/8 whose representation would be
  /// 100100100100). It also allows a unique numeric represention of different
  /// accent patterns for meter with the same number of divisions per cycle.
  /// For example, 7/8 can be represented as either 1010100 or 1001010, which
  /// are unique numbers. Therefore, it is possible to compare these against
  /// one another and know that they have the same number of beats per cycle,
  /// the same number of divisions per cycle, but since they are different
  /// numbers, they are not equivalent since the beats (pulses) occur at
  /// different places in the cycle.
  final int id;

  /// The note value of each beat, for example, a quarter note.
  final NoteValue value;

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
  List<Object> get props => [id];

  @override
  String toString() {
    // TODO: if groupings are uneven then display as (n + m)
    switch (classification) {
      case MeterClassification.simple:
        return '$beatsPerCycle/$value';
      default:
        return '$divisionsPerCycle/$value';
    }
  }

  static int _createId(int beatCount, [List<int>? grouping]) =>
      _convertGroupingToId(grouping ?? _createDefaultGrouping(beatCount));

  static List<int> _createDefaultGrouping(int beatCount) {
    if (beatCount <= 4) return List.generate(beatCount, (i) => 2);

    var n = beatCount;
    final groups = <int>[];

    while (n > 4) {
      groups.add(3);
      n -= 3;
    }

    while (n > 0) {
      final count = n == 3 ? 3 : 2;
      groups.add(count);
      n -= count;
    }

    return groups;
  }

  static int _convertGroupingToId(List<int> groupings) {
    var id = 0;
    var cumulativeDivisionsCount = 0;
    final totalDivisionsCount = groupings.sum;

    for (var i = 0; i < groupings.length; i++) {
      id |= pow(
        2,
        (totalDivisionsCount - cumulativeDivisionsCount - 1) %
            totalDivisionsCount,
      ) as int;
      cumulativeDivisionsCount += groupings[i];
    }

    return id;
  }
}
