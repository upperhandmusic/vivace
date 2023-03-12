import 'package:vivace_core/rhythm.dart';
import 'package:vivace_tools/metronome.dart';

void main() {
  const tempo = Tempo(120);
  final meter = Meter(3, NoteValue.quarter);
  // ignore: avoid_print
  Metronome.basic(tempo, meter: meter).start(print);
}
