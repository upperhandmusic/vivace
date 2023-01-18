import '_binary.dart';
import 'pitch_class.dart';

class Scale {
  /// The starting pitch class for the scale, for example "D#"
  final PitchClass tonic;

  /// The numeric identity of the scale from its binary representation, see
  /// https://ianring.com/musictheory/scales/ for more details.
  final int identity;

  Scale(this.tonic, this.identity);
  const Scale.majorPentatonic(this.tonic) : identity = 661;
  const Scale.minorPentatonic(this.tonic) : identity = 1193;
  const Scale.blues(this.tonic) : identity = 1257;
  const Scale.wholetone(this.tonic) : identity = 1365;
  const Scale.major(this.tonic) : identity = 2741;
  const Scale.harmonicMajor(this.tonic) : identity = 2485;
  const Scale.naturalMinor(this.tonic) : identity = 1453;
  const Scale.harmonicMinor(this.tonic) : identity = 2477;
  const Scale.melodicMinor(this.tonic) : identity = 2733;
  const Scale.octatonic(this.tonic) : identity = 1755;
  const Scale.chromatic(this.tonic) : identity = 4095;

  int get modeCount => identity.countEnabledBits();

  Scale mode(int modeNumber) {
    assert(modeNumber >= 1, 'modeNumber must be greater or equal to 1');
    assert(modeNumber <= modeCount,
        'modeNumber must be less than or equal to $modeCount');

    if (modeNumber == 1) return this;

    var modeScaleDegree = identity.enabledBits[modeNumber - 1];
    var newIdentity = identity.rotateRight(modeScaleDegree);
    var newTonic = PitchClass(modeScaleDegree);

    return Scale(newTonic, newIdentity);
  }

  Set<PitchClass> toSet() {
    return identity.enabledBits.map(PitchClass.new).toSet();
  }

  List<PitchClass> toList() {
    return identity.enabledBits.map(PitchClass.new).toList();
  }

  PitchClass operator [](int scaleDegree) {
    return toList().elementAt(scaleDegree - 1);
  }
}
