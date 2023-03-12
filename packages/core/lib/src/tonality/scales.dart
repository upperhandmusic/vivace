import '../helpers/_binary.dart';
import '../pitch/pitch_class.dart';

class Scale {
  const Scale({required this.tonic, required this.id});

  const Scale.chromatic(this.tonic) : id = 4095;
  const Scale.octatonic(this.tonic) : id = 1755;
  const Scale.melodicMinor(this.tonic) : id = 2733;
  const Scale.harmonicMinor(this.tonic) : id = 2477;
  const Scale.naturalMinor(this.tonic) : id = 1453;
  const Scale.harmonicMajor(this.tonic) : id = 2485;
  const Scale.major(this.tonic) : id = 2741;
  const Scale.wholetone(this.tonic) : id = 1365;
  const Scale.blues(this.tonic) : id = 1257;
  const Scale.minorPentatonic(this.tonic) : id = 1193;

  const Scale.majorPentatonic(this.tonic) : id = 661;

  // TODO: make this work with a PitchClassSet instead because it's hard to
  // ensure that the input list of pitch classes is correct (min, max,
  // uniqueness)
  // A PitchClassSet value object can validate its inputs when constructed.
  Scale.fromList({required this.tonic, required List<int> pitchClasses})
      : id =
            pitchClasses.fold(0, (n, pitchClass) => n | pitchClass.asBitMask()),
        assert(
          pitchClasses.every((element) => element >= _lowestPitchClass),
          'All pitch classes must be >= $_lowestPitchClass',
        ),
        assert(
          pitchClasses.every((element) => element <= _highestPitchClass),
          'All pitch classes must be <= $_highestPitchClass',
        );

  /// The starting pitch class for the scale, for example "D#"
  final PitchClass tonic;

  /// The numeric identity of the scale from its binary representation, see
  /// https://ianring.com/musictheory/scales/ for more details.
  final int id;

  static const _lowestPitchClass = 0;

  static const _highestPitchClass = 11;

  int get modeCount => id.countEnabledBits();

  Scale mode(int modeNumber) {
    assert(modeNumber >= 1, 'modeNumber must be greater or equal to 1');
    assert(
      modeNumber <= modeCount,
      'modeNumber must be less than or equal to $modeCount',
    );

    if (modeNumber == 1) return Scale(tonic: tonic, id: id);

    final modeScaleDegree = id.enabledBits[modeNumber - 1];
    final newIdentity = id.rotateRight(modeScaleDegree);
    final newTonic = PitchClass.at(modeScaleDegree);

    return Scale(tonic: newTonic, id: newIdentity);
  }

  Set<PitchClass> toSet() => id.enabledBits.map(PitchClass.at).toSet();

  List<PitchClass> toList() => id.enabledBits.map(PitchClass.at).toList();

  PitchClass operator [](int scaleDegree) =>
      toList().elementAt(scaleDegree - 1);
}
