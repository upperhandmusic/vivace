import './note_value.dart';

class Tempo {
  const Tempo(this.beatsPerMinute, [this.noteValue = NoteValue.quarter]);

  final double beatsPerMinute;

  final NoteValue noteValue;

  /// Get a new [Tempo] at half the beats per minute of.
  Tempo get halved => this / 2;

  /// Get a new [Tempo] at double the beats per minute.
  Tempo get doubled => this * 2;

  /// Get a new [Tempo] with beats per minute increased by 1.
  Tempo get increment => this + 1;

  /// Get a new [Tempo] with beats per minute decreased by 1.
  Tempo get decrement => this - 1;

  Tempo operator +(double value) => Tempo(beatsPerMinute + value);

  Tempo operator -(double value) => Tempo(beatsPerMinute - value);

  Tempo operator *(double value) => Tempo(beatsPerMinute * value);

  Tempo operator /(double value) => Tempo(beatsPerMinute / value);

  double get beatsPerSecond => beatsPerMinute / 60;

  double get beatsPerMillisecond => beatsPerSecond / 1000;
}
