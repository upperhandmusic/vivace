import 'dart:async';
import 'package:clock/clock.dart';
import 'package:vivace_core/rhythm.dart';
import './metronome_event.dart';

// class MetronomeOptions {

// }

/// Produces beat events at a timed interval based on the provided options.
///
/// ```dart
/// var metronome = Metronome(const Tempo(120));
/// metronome.start(playMetronomeSound);
/// metronome.stop();
///
/// var metronome = Metronome.basic();
/// metronome.listen((event) {});
/// metronome.pause();
/// metronome.resume();
/// metronome.cancel();
///
/// metronome.where((event) => event.beat)
/// ```
class Metronome {
  // TODO: allow configuring metronome tick division
  Metronome(this.tempo, [this.meter = defaultMeter]) {
    _controller = StreamController.broadcast(
      onListen: () => _startTimer(_clock.now()),
      onCancel: _cancelTimer,
    );
  }

  Metronome.subdivided({
    Meter meter = defaultMeter,
    NoteValue? subdivision,
  }) : subdivision = subdivision ?? meter.value.division;

  Metronome.basic({Meter meter = defaultMeter})
      : subdivision = meter.value.division;
  static const Meter defaultMeter = Meter.commonTime();

  final Meter meter;

  final Tempo tempo;

  final NoteValue subdivision;

  final Clock _clock = const Clock();

  final Timer _timer;

  late final Stream<MetronomeEvent> _stream;

  late final StreamController<MetronomeEvent> _controller;

  late final StreamSubscription<MetronomeEvent> _subscription;

  void start(void Function(MetronomeEvent event) onData) {
    // is controller necessary? Can I just listen and start timer here since
    // I'm not returning the stream subscription?
    _stream = _controller.stream;
    _subscription = _controller.stream.listen(onData);
  }

  Future<void> stop() async {
    // TODO: handle case if stop() is called before start() and subscription
    // does not yet exist. Throw error explaining start() must be called first.
    await _subscription.cancel();
  }

  Stream<MetronomeEvent> alternate() {
    // TODO: need MetronomeEvent to have count information so that
    // we can take only what we want here
    // 4/4 only click on 2 & 4
    // TODO: how do you do this with odd time signatures?
    // 3/4 only click on 3
    // 5/4 only click on 2 & 5 or only click on 3 & 5 (3+2/4)
    // 7/4 only click on 3 & 7 or only click on 4 & 7 (4+3/4) - how?
    // timeSignature.beatsPerMeasure % 2 !== 0
    _stream.takeWhile((event) => event.beat / meter.beatsPerMeasure);
  }

  void _startTimer(DateTime now) {
    // TODO: calculate duration from tempo and time signature
    // interval is ms / beat
    final intervalMs = (1 / tempo.beatsPerMillisecond).round();
    final nextTickMs = intervalMs - (now.millisecondsSinceEpoch % intervalMs);
    final timer = Timer(Duration(milliseconds: nextTickMs), _tick);
  }

  _cancelTimer() {
    _timer.cancel();
  }

  void _tick() {
    // TODO: figure out how to tick for beat subdivisions
    // timeSignature.beatsPerMeasure;
    _controller.add(MetronomeEventType.beat);
    _startTimer(_clock.now());
  }
}
