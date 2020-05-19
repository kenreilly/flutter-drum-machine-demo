
import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/sample-player.dart';

class Pad extends StatelessWidget {

	Pad({ this.height, this.width, this.value });

	final double height;
	final double width;
	final int value;

	static List<Color> _colors = [
		Colors.red,
		Colors.amber,
		Colors.purple,
		Colors.blue,
		Colors.cyan,
		Colors.pink,
	];

	DRUM_SAMPLE get sample => DRUM_SAMPLE.values[value];

	String get name => SamplePlayer.samples[sample];

	Color get color => _colors[sample.index];

	void on() => SamplePlayer.play(sample);

	@override
	Widget build(BuildContext context) {
		
		return SizedBox(
			height: height * .82,
			width: width * .88,
			child: Container(
				alignment: Alignment.center,
				decoration: BoxDecoration(
					border: Border.all(color: color),
					borderRadius: BorderRadius.all(Radius.circular(4)),
					color: color.withOpacity(0.12)
				),
				child: SizedBox.expand( 
					child: MaterialButton(
						splashColor: Color.lerp(color, Colors.black, .8),
						child: Text(name),
						onPressed: on 
					)
				)
			)
		);
	}
}