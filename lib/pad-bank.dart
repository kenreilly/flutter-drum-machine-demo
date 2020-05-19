
import 'package:flutter/material.dart';
import 'package:flutter_drum_machine_demo/pad.dart';

class PadBank extends StatelessWidget {

	PadBank();

	@override
	Widget build(BuildContext context) {

		Size size = MediaQuery.of(context).size;
		double padBankHeight = (size.height / 3);
		double padHeight = padBankHeight / 2;
		double padWidth = size.width / 3; 

		return Container(
			height: padBankHeight,
			color: Colors.black38,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: List<Widget>.generate(2, (i) => 
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: List<Widget>.generate(3, (j) => 
							Pad(
								height: padHeight, 
								width: padWidth, 
								value: 3 * i + j
							)
						)
					)
				)
			)
		);
	}
}