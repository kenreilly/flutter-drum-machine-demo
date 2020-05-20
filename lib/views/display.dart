import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/audio-engine.dart';
import 'package:flutter_drum_machine_demo/views/base-widget.dart';

class Display extends BaseWidget {

	Display({Key key}) : super(key: key);

	@override
	_DisplayState createState() => _DisplayState();
}

class _DisplayState extends BaseState<Display> {

	Color _color = Color.lerp(Colors.brown, Colors.black, 0.7);

	String get _label => AudioEngine.bpm.toString() + 'bpm';

	bool get _isRunning => AudioEngine.state != ControlState.READY;

	int get _step => AudioEngine.step;

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
						padding: EdgeInsets.all(4),
						width: labelWidth,
						child: Container(
							decoration: BoxDecoration(
								color: Colors.black26,
								border: Border.all(color: Colors.pink.withOpacity(0.32)),
								borderRadius: BorderRadius.circular(2),
							),
							child: SizedBox.expand(
								child: MaterialButton(
									padding: EdgeInsets.zero,
									onPressed: () {},
									child: Text(_label, style: style)
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
										margin: EdgeInsets.all(4),
										decoration: BoxDecoration(
											color: (_step == i && _isRunning) ? Colors.grey.withOpacity(0.2) : Colors.black26,
											border: Border.all(color: Colors.yellow.withOpacity(0.12)),
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
