import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/audio-engine.dart';
import 'package:flutter_drum_machine_demo/services/sampler.dart';
import 'package:flutter_drum_machine_demo/views/track.dart';

class Sequencer extends StatelessWidget {

	Sequencer({Key key}) : super(key: key);

	final BorderSide _border = BorderSide(color: Colors.amber.withOpacity(0.4));

	@override
	Widget build(BuildContext context) {

		double labelWidth = MediaQuery.of(context).size.width / 5;

		return Expanded(
			child: Container(
				decoration: BoxDecoration(
					border: Border(top: _border),
					color: Colors.black45,
				),
				child: Column(
					children: List<Widget>.generate(Sampler.samples.length, (i) => 
						Expanded(
							child: Container(
								decoration: BoxDecoration(border: Border(bottom: _border)),
								child: Row(
									crossAxisAlignment: CrossAxisAlignment.stretch,
									children: <Widget>[
										InkWell(
											enableFeedback: false,
											onTap: () => AudioEngine.on<PadEvent>(PadEvent(DRUM_SAMPLE.values[i])),
											child: Container(
												width: labelWidth,
												color: Sampler.colors[i].withOpacity(0.2),
												child: Center(child: Text(Sampler.samples[DRUM_SAMPLE.values[i]]))
											),
										),
										Track(sample: DRUM_SAMPLE.values[i])
									]
								)
							)
						)
					),
				)
			)
		);
	}
}
