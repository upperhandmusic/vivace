import 'package:collection/collection.dart';
import 'pitch_class.dart';

class PitchClassSet extends UnmodifiableSetView<PitchClass> {
  PitchClassSet._(Iterable<int> pitchClasses) : super(_convert(pitchClasses));

  factory PitchClassSet.from(Iterable<int> pitchClasses) {
    return PitchClassSet._(pitchClasses);
  }

  static Set<PitchClass> _convert(Iterable<int> pitchClasses) {
    return Set.of(pitchClasses
        .sorted((int a, int b) => a.compareTo(b))
        .map(PitchClass.from));
  }
}
