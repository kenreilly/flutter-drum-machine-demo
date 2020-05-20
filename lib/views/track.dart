import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/audio-engine.dart';
import 'package:flutter_drum_machine_demo/services/sampler.dart';

class Track extends StatefulWidget {

	Track({ Key key, @required this.sample }) : super(key: key);

	final DRUM_SAMPLE sample;

	@override
	_TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {

	StreamSubscription<Signal> _stream;

	List<bool> _data = List.generate(8, (i) => false);

	void on<Signal>(Signal signal) => setState(() => _data = AudioEngine.trackdata[widget.sample]);

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

	Color getItemColor(int i) => (_data[i] == true) 
		? Sampler.colors[widget.sample.index].withOpacity(0.4)
		: (i % 2 == 0) ? Colors.black38 : Colors.transparent;

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
								child: Container(
									margin: EdgeInsets.symmetric(horizontal: 1),
									color: getItemColor(i)
								),								
								onTap: () => AudioEngine.on<EditEvent>(EditEvent(widget.sample, i))
							)
						)
					)
				)
			)
		);
	}
}