import 'package:collection/collection.dart';
import './pitch_class.dart';

class PitchClassSet extends UnmodifiableSetView<PitchClass> {
  /// Takes a set of pitch classes, interprets the first pitch class as the
  /// root, and determines the prime form of the pitch class set then stores
  /// it as an integer id property
  PitchClassSet(Set<int> pitchClasses) : super(_convert(pitchClasses));

  PitchClassSet._(Iterable<int> pitchClasses) : super(_convert(pitchClasses));

  factory PitchClassSet.from(Iterable<int> pitchClasses) =>
      PitchClassSet._(pitchClasses);

  static Set<PitchClass> _convert(Iterable<int> pitchClasses) =>
      Set.of(pitchClasses.sorted((a, b) => a.compareTo(b)).map(PitchClass.at));

  // get normalForm {}
}
