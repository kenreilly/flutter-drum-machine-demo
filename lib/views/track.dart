import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/sampler.dart';

class Track extends StatefulWidget {

	Track({ Key key, @required this.sample }) : super(key: key);

	final DRUM_SAMPLE sample;

	@override
	_TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {

	@override
	Widget build(BuildContext context) {
		
		return Expanded( 
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: List<Widget>.generate(8, (i) => 
					Expanded(
						child: SizedBox.expand(
							child:  MaterialButton(
								color: (i % 2 == 0) ? Colors.black38 : Colors.transparent,
								onPressed: () {},
							)
						)
					)
				)
			)
		);
	}
}