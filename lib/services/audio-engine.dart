import 'dart:async';
import 'package:flutter_drum_machine_demo/services/sampler.dart';

enum ControlState { READY, PLAY, RECORD }

class Event { const Event(); }
class TickEvent extends Event {}

class ControlEvent extends Event {
	const ControlEvent(this.state);
	final ControlState state; 
}

class PadEvent extends Event {
	const PadEvent(this.sample);
	final DRUM_SAMPLE sample;
}

class EditEvent extends Event {
	const EditEvent(this.sample, this.position);
	final DRUM_SAMPLE sample;
	final int position;
}

class Signal {}

abstract class AudioEngine {

	// Each pattern has eight steps
	static const int _resolution = 8;
	static int step = 0;

	// Engine control current state
	static ControlState _state = ControlState.READY;
	static get state => _state;

	// Beats per minute
	static double _bpm = 120.0;
	static set bpm(x) { _bpm = x; _signal.add(x); }
	static get bpm => _bpm;

	// Generates a new blank track data structure
	static Map<DRUM_SAMPLE, List<bool>> get _blanktape =>
		Map.fromIterable(DRUM_SAMPLE.values, key: (k) => k, value: (v) => List.generate(8, (i) => false));

	// Track note on/off data
	static Map<DRUM_SAMPLE, List<bool>> _trackdata = _blanktape;
	static get trackdata => _trackdata;

	// Timer tick duration: (bpm / sec_per_min * ms_per_sec / pattern_resolution)
	static Duration get _tick => Duration(milliseconds: (bpm / 60 * 1000 / _resolution).round()); 
	static Timer _timer;

	// Outbound signal driver - allows widgets to listen for signals from audio engine
	static StreamController<Signal> _signal = StreamController<Signal>.broadcast();
	static Future<void> close() => _signal.close(); // Not used but required by SDK
	static StreamSubscription<Signal> listen(Function(Signal) onData) => _signal.stream.listen(onData);

	// Incoming event handler
	static void on<T extends Event>(Event event) {

		switch (T) {

			case PadEvent:
				Sampler.play((event as PadEvent).sample);
				if (state == ControlState.RECORD) { processInput(event); }
				return;

			case TickEvent:
				if (state == ControlState.READY) { return; }
				return next();

			case EditEvent:
				return edit(event);

			case ControlEvent:
				return control(event);
		}
	}

	// Controller state change handler
	static control(ControlEvent event) {
	
		switch (event.state) {

			case ControlState.PLAY:
			case ControlState.RECORD:
				if (state == ControlState.READY) {start(); }
				break;

			case ControlState.READY:
			default:
				reset();
		}

		_state = event.state;
		_signal.add(Signal());
	}

	// Note block edit event handler
	static void edit(EditEvent event) {

		trackdata[event.sample][event.position] = !trackdata[event.sample][event.position];
		_signal.add(Signal());
	}

	static void processInput(PadEvent event) {

		
	}

	static void reset() { 

		step = 0;
		if (_timer != null) { _timer.cancel(); }
	}
		
	static void start() {

		reset();
		_timer = Timer.periodic(_tick, (t) => on<TickEvent>(TickEvent()));
	}

	static void next() {
		
		step = (step == 7) ? 0 : step + 1;
		_signal.add(Signal());
	}
}