import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/audio-engine.dart';
import 'package:flutter_drum_machine_demo/services/sampler.dart';
import 'package:flutter_drum_machine_demo/views/base-widget.dart';

class Track extends BaseWidget {

	Track({ Key key, @required this.sample }) : super(key: key);

	final DRUM_SAMPLE sample;

	@override
	_TrackState createState() => _TrackState();
}

class _TrackState extends BaseState<Track> {

	List<bool> _data = List.generate(8, (i) => false);

	bool get isRunning => AudioEngine.state != ControlState.READY;

	Color get color => Sampler.colors[widget.sample.index];

	Color getItemColor(int i) => (_data[i] == true) 
		? (i == AudioEngine.step && isRunning) ? color.withOpacity(0.6) : color.withOpacity(0.4)
		: (i % 2 == 0) ? Colors.black38 : Colors.transparent;

	@override
	void on<Signal>(Signal signal) => setState(() => _data = AudioEngine.trackdata[widget.sample]);

	@override
	Widget build(BuildContext context) {
		
		return Expanded( 
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: List<Widget>.generate(8, (i) => 
					Expanded(
						child: SizedBox.expand(
							child: InkWell(
								enableFeedback: false,
								onTap: () => AudioEngine.on<EditEvent>(EditEvent(widget.sample, i)),
								child: Container(
									margin: EdgeInsets.symmetric(horizontal: 1),
									color: getItemColor(i)
								)
							)
						)
					)
				)
			)
		);
	}
}
