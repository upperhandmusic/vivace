import '_binary.dart';
import 'pitch_class.dart';

class Scale {
  /// The starting pitch class for the scale, for example "D#"
  final PitchClass tonic;

  /// The numeric identity of the scale from its binary representation, see
  /// https://ianring.com/musictheory/scales/ for more details.
  final int id;

  const Scale({required this.tonic, required this.id});

  // TODO: make this work with a PitchClassSet instead because it's hard to
  // ensure that the input list of pitch classes is correct (min, max, uniqueness)
  // A PitchClassSet value object can validate its inputs when constructed.
  Scale.fromList({required this.tonic, required List<int> pitchClasses})
      : id =
            pitchClasses.fold(0, (n, pitchClass) => n | pitchClass.asBitMask()),
        assert(pitchClasses.every((element) => element >= 0)),
        assert(pitchClasses.every((element) => element <= 11));

  const Scale.majorPentatonic(this.tonic) : id = 661;
  const Scale.minorPentatonic(this.tonic) : id = 1193;
  const Scale.blues(this.tonic) : id = 1257;
  const Scale.wholetone(this.tonic) : id = 1365;
  const Scale.major(this.tonic) : id = 2741;
  const Scale.harmonicMajor(this.tonic) : id = 2485;
  const Scale.naturalMinor(this.tonic) : id = 1453;
  const Scale.harmonicMinor(this.tonic) : id = 2477;
  const Scale.melodicMinor(this.tonic) : id = 2733;
  const Scale.octatonic(this.tonic) : id = 1755;
  const Scale.chromatic(this.tonic) : id = 4095;

  int get modeCount => id.countEnabledBits();

  Scale mode(int modeNumber) {
    assert(modeNumber >= 1, 'modeNumber must be greater or equal to 1');
    assert(modeNumber <= modeCount,
        'modeNumber must be less than or equal to $modeCount');

    if (modeNumber == 1) return this;

    var modeScaleDegree = id.enabledBits[modeNumber - 1];
    var newIdentity = id.rotateRight(modeScaleDegree);
    var newTonic = PitchClass.from(modeScaleDegree);

    return Scale(tonic: newTonic, id: newIdentity);
  }

  Set<PitchClass> toSet() {
    return id.enabledBits.map(PitchClass.from).toSet();
  }

  List<PitchClass> toList() {
    return id.enabledBits.map(PitchClass.from).toList();
  }

  PitchClass operator [](int scaleDegree) {
    return toList().elementAt(scaleDegree - 1);
  }
}
