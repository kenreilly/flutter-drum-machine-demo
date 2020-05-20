import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum DRUM_SAMPLE { KICK, SNARE, HAT, TOM1, TOM2, CRASH }

abstract class Sampler {

	static String _ext = '.wav';

	static Map<DRUM_SAMPLE, String> samples = const {
		DRUM_SAMPLE.KICK: 'kick',
		DRUM_SAMPLE.SNARE: 'snare',
		DRUM_SAMPLE.HAT: 'hat',
		DRUM_SAMPLE.TOM1: 'tom1',
		DRUM_SAMPLE.TOM2: 'tom2',
		DRUM_SAMPLE.CRASH: 'crash'
	};

	static List<Color> colors = [
		Colors.red,
		Colors.amber,
		Colors.purple,
		Colors.blue,
		Colors.cyan,
		Colors.pink,
	];

	static List<String> _files = List.generate(samples.length, (i) => samples[DRUM_SAMPLE.values[i]] + _ext);

	static AudioCache _cache = AudioCache(respectSilence: true);

	static Future<void> init() => _cache.loadAll(_files);

	static void play(DRUM_SAMPLE sample) => _cache.play(samples[sample] + _ext, mode: PlayerMode.LOW_LATENCY);
}