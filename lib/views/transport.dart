import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/audio-engine.dart';

class Transport extends StatefulWidget {

	Transport({Key key}) : super(key: key);

	@override
	_TransportState createState() => _TransportState();
}

class _TransportState extends State<Transport> {

	StreamSubscription<Signal> _stream; 
	ControlState _state;

	Map<ControlState, Icon> get _icons => {
		ControlState.READY: Icon(Icons.stop, color: (_state == ControlState.READY) ? Colors.blue : Colors.white),
		ControlState.PLAY: Icon(Icons.play_arrow, color: (_state == ControlState.PLAY) ? Colors.green : Colors.white),
		ControlState.RECORD: Icon(Icons.fiber_manual_record, color: (_state == ControlState.RECORD) ? Colors.red : Colors.white)
	};

	final BoxDecoration _decoration = BoxDecoration(
		color: Colors.black54,
		border: Border(bottom: BorderSide(color: Colors.blueGrey.withOpacity(0.6)))
	);

	void on<Signal>(Signal signal) => setState(() => _state = AudioEngine.state );

	void onTap(ControlState state) => AudioEngine.on<ControlEvent>(ControlEvent(state));

	@override
	void initState() {

		_stream = AudioEngine.listen(on);
		super.initState();
	}

	@override
	void dispose() {

		_stream.cancel();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {

		return Container(
			decoration: _decoration,
			height: 64,
			padding: EdgeInsets.symmetric(horizontal: 8),
			child: Row(
				children: List<Widget>.generate(ControlState.values.length, (i) => 
					Expanded(
						child: SizedBox.expand(
							child: Container(
								padding: EdgeInsets.symmetric(horizontal: 4),
								child: MaterialButton(
									disabledColor: Colors.black54,
									onPressed: (_state == ControlState.values[i]) ? null : () => onTap(ControlState.values[i]),
									child: _icons[ControlState.values[i]]
								),
							)
						)
					)
				)
			)
		);
	}
}