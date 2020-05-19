import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drum_machine_demo/pad-bank.dart';
import 'package:flutter_drum_machine_demo/sample-player.dart';
import 'package:flutter_drum_machine_demo/transport.dart';


void main() async {

	WidgetsFlutterBinding.ensureInitialized();
	SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

	await SamplePlayer.init();
	runApp(Game());
}

class Game extends StatelessWidget {

	final String _title = "Flutter Drum MachineDemo";

	@override
	Widget build(BuildContext context) {

		return MaterialApp(
			title: _title,
			theme: ThemeData.dark(),
			home: Scaffold(
				appBar: AppBar(title: Center(child: Text(_title))),
				body: Column(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						Expanded(child: Text("TODO sequencere")),
						Transport(),
						PadBank()
					]
				),
			)
		);
	}
}
