import 'package:test/test.dart';
import 'package:vivace_core/rhythm.dart';
import 'package:vivace_tools/metronome.dart';

void main() {
  group('A group of tests', () {
    const tempo = Tempo(120);
    final metronome = Metronome(tempo);

    test('Ticks on every beat by default', () {
      // TODO: write tests for Metronome
      metronome.start((event) {
        expect(event, isA<MetronomeEvent>());
      });
    });
  });
}
