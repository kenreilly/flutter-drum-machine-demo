
import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/services/sampler.dart';

class Pad extends StatelessWidget {

	Pad({ this.height, this.width, this.value });

	final double height;
	final double width;
	final int value;

	DRUM_SAMPLE get sample => DRUM_SAMPLE.values[value];

	String get name => Sampler.samples[sample];

	Color get color => Sampler.colors[sample.index];

	void on() => Sampler.play(sample);

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
					child: InkWell(
						child: Center(child: Text(name)),
						enableFeedback: false,
						onTap: on,
					)
				)
			)
		);
	}
}