import 'dart:async';
import 'dart:math';
import 'package:flutter_drum_machine_demo/services/sampler.dart';

enum ControlState { READY, PLAY, RECORD }

class Event { }
class TickEvent extends Event {}

class ControlEvent extends Event {
	ControlEvent(this.state);
	ControlState state; 
}

class AudioEvent extends Event {
	AudioEvent(this.sample);
	DRUM_SAMPLE sample;
}

class Signal {}

abstract class AudioEngine {

	static ControlState _state = ControlState.READY;
	static get state => _state;

	static double _bpm = 120.0;
	static set bpm(x) { _bpm = x; _signal.add(x); }
	static get bpm => _bpm;

	static int step = 0;

	static Duration get _tick => Duration(milliseconds: 500); // 1/2 of sequencer length = 4 beats

	static Timer _timer;

	static StreamController<Signal> _signal = StreamController<Signal>.broadcast();
	static Future<void> close() => _signal.close(); // Not used but required by SDK

	static StreamSubscription<Signal> listen(Function(Signal) onData) => _signal.stream.listen(onData);

	static void on<T extends Event>(Event event) {

		switch (T) {

			case TickEvent:
				if (AudioEngine.state != ControlState.PLAY) { return; }
				return next();

			case AudioEvent:
				print("auio");
				break;

			case ControlEvent:
				return control(event);
		}
	}

	static control(ControlEvent event) {

		_state = event.state;

		if (_timer != null) { _timer.cancel(); }
	
		switch (_state) {

			case ControlState.PLAY:
				_timer = Timer.periodic(_tick, (t) => on<TickEvent>(TickEvent()));
				break;

			case ControlState.RECORD:
				// TODO: Handle this case.
				break;

			case ControlState.READY:
			default:
				break;
		}

		_signal.add(Signal());
	}

	static void next() {
		
		step = (step == 7) ? 0 : step + 1;
		_signal.add(Signal());
	}

	static void record() {

	}


}