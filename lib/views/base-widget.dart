import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/audio-engine.dart';

class BaseWidget extends StatefulWidget {
	
	BaseWidget({ key: Key }) : super(key: key);

	@override
	BaseState createState() => BaseState();
}

class BaseState<T extends BaseWidget> extends State<T> {

	StreamSubscription<Signal> _stream;

	void on<Signal>(Signal s) => setState(() => null);

	@override
	void initState() {
		
		_stream = AudioEngine.listen(on);
		super.initState();
	}
	
	@override
	void dispose() {

		if (_stream != null) { _stream.cancel(); }
		super.dispose();
	}

	@override
	Widget build(BuildContext context) => Container();
}
