enum MetronomeEventType {
  downbeat,
  beat,
  upbeat,
  subdivision;
}

/// An individual event in a stream of events created by a running metronome.
/// Each [MetronomeEvent] represents a beat or beat subdivision of a measure
/// and can be used to implement time-based musical concepts that adhere to
/// a given meter.
///
///
/// The [type] attribute can be used for matching in a switch/case statement.
/// A typical use case would be to play different click sounds depending
/// on the event type. For example:
///
/// ```dart
/// switch (event.type) {
///   case MetronomeEventType.downbeat:
///     playDownbeatClick();
///     break;
///   case MetronomeEventType.subdivision:
///     playSubdivisionClick();
///     break;
///   default:
///     playDefaultClick();
/// }
/// ```
class MetronomeEvent {
  MetronomeEvent({required this.type, required this.beat});

  final MetronomeEventType type;

  final int beat;

  bool get isDownbeat => type == MetronomeEventType.downbeat;

  bool get isUpbeat => type == MetronomeEventType.upbeat;

  bool get isSubdivision => type == MetronomeEventType.subdivision;
}
