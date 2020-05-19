
import 'package:flutter/material.dart';

enum ControlState { READY, PLAY, RECORD }

class Transport extends StatefulWidget {

	Transport({Key key}) : super(key: key);

	@override
	_TransportState createState() => _TransportState();
}

class _TransportState extends State<Transport> {

	ControlState _state = ControlState.READY;

	Map<ControlState, Icon> get _icons => {
		ControlState.READY: Icon(Icons.stop, color: (_state == ControlState.READY) ? Colors.blue : Colors.white),
		ControlState.PLAY: Icon(Icons.play_arrow, color: (_state == ControlState.PLAY) ? Colors.green : Colors.white),
		ControlState.RECORD: Icon(Icons.fiber_manual_record, color: (_state == ControlState.RECORD) ? Colors.red : Colors.white)
	};

	final BoxDecoration _decoration = BoxDecoration(
		color: Colors.black54,
		border: Border.symmetric(vertical: BorderSide(color: Colors.blueGrey.withOpacity(0.6)))
	);

	void on(ControlState state) {

		switch (state) {
			case ControlState.READY:
			case ControlState.PLAY:
			case ControlState.RECORD:
		}

		setState(() { _state = state; });
	}

	@override
	Widget build(BuildContext context) {

		return Container(
			decoration: _decoration,
			height: 64,
			padding: EdgeInsets.symmetric(horizontal: 8),
			child: Row(
				children: List<Widget>.generate(ControlState.values.length, (i) => Expanded(
					child: SizedBox.expand(
						child: Container(
							padding: EdgeInsets.symmetric(horizontal: 4),
							child: MaterialButton(
								disabledColor: Colors.black54,
								onPressed: (_state == ControlState.values[i]) ? null : () => on(ControlState.values[i]),
								child: _icons[ControlState.values[i]]
							),
						)
					)
				))
			)
		);
	}
}