/// Defines core functionality for working with rhythmic concepts, such as meter
/// and tempo.
///
/// **Meter**
///
/// ```dart
/// final beatsPerMeasureRange = List<int>.generate(23, (i) => i + 1);
/// final noteValueRange = NoteValue.values;
///
/// Meter selectMeter(int selectedBeatsPerMeasure,
///   NoteValue selectedNoteValue) =>
///       Meter(selectedBeatsPerMeasure, selectedNoteValue);
///
/// Stream<int>
/// ```

export 'src/rhythm/meter.dart';
export 'src/rhythm/note_value.dart';
export 'src/rhythm/tempo.dart';
