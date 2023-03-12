import 'package:collection/collection.dart';
import './pitch_class.dart';

class PitchClassSet extends UnmodifiableSetView<PitchClass> {
  PitchClassSet._(Iterable<int> pitchClasses) : super(_convert(pitchClasses));

  factory PitchClassSet.from(Iterable<int> pitchClasses) =>
      PitchClassSet._(pitchClasses);

  static Set<PitchClass> _convert(Iterable<int> pitchClasses) =>
      Set.of(pitchClasses.sorted((a, b) => a.compareTo(b)).map(PitchClass.at));

  // get normalForm {}
}
