import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/audio-engine.dart';

class Display extends StatefulWidget {

	Display({Key key}) : super(key: key);

	@override
	_DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {

	Color _color = Color.lerp(Colors.deepOrange, Colors.black, 0.88);

	String get label => "120bpm";

	StreamSubscription<Signal> _stream;

	int _step = 0;

	bool get isRunning => AudioEngine.state != ControlState.READY;

	void on<Signal>(Signal s) => setState(() { _step = AudioEngine.step; });

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

		double labelWidth = MediaQuery.of(context).size.width / 5;
		TextStyle style = Theme.of(context).textTheme.overline;

		return Container(
			height: 48,
			color: _color,
			child: Row(
				children: <Widget>[
					Container(
						padding: EdgeInsets.all(6),
						width: labelWidth,
						child: Container(
							decoration: BoxDecoration(
								color: Colors.black26,
								border: Border.all(color: Colors.pink.withOpacity(0.32)),
								borderRadius: BorderRadius.circular(4),
							),
							child: SizedBox.expand(
								child: MaterialButton(
									padding: EdgeInsets.zero,
									onPressed: () {},
									child: Text(label, style: style)
								)
							)
						)
					),
					Expanded( 
						child: Row(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: List<Widget>.generate(8, (i) => 
								Expanded(
									child: Container(
										margin: EdgeInsets.all(6),
										decoration: BoxDecoration(
											color: (_step == i && isRunning) ? Colors.indigo.withOpacity(0.6) : Colors.transparent,
											border: Border.all(color: Colors.amber.withOpacity(0.26)),
											borderRadius: BorderRadius.circular(2)
										)
									)
								)
							)
						)
					)
				]
			)
		);
	}
}