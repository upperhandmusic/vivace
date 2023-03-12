/// Common base tuning system from which all tuning systems extend.
abstract class TuningSystem {
  // final Frequency anchorFrequency;
  // ImmutableListView<Frequency>
  // final int pitchCount;
}

class EqualTemperment extends TuningSystem {}

// 1:1, 9:8, 5:4, 4:3, 3:2, 5:3, 15:8, 2:1
class JustIntonation extends TuningSystem {}

class MeantoneTemperment extends TuningSystem {}

class CustomTuning extends TuningSystem {}
