import 'package:collection/collection.dart';
import 'pitch_class.dart';

class PitchClassSet extends UnmodifiableSetView<PitchClass> {
  PitchClassSet(Iterable<int> pitchClasses) : super(_convert(pitchClasses));

  static Set<PitchClass> _convert(Iterable<int> pitchClasses) {
    return Set.of(pitchClasses
        .sorted((int a, int b) => a.compareTo(b))
        .map(PitchClass.new));
  }
}
