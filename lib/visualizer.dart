import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:test1/callbacks.dart';
import 'package:test1/flutter_visualizers.dart';

class Visualizer extends StatefulWidget {
  final Function(BuildContext context, List<int> fft) builder;
  final int id;

  Visualizer({
    required this.builder,
    required this.id,
  });

  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  late AudioVisualizer visualizer;
  List<int> fft = [];

  @override
  void initState() {
    super.initState();
    visualizer = AudioVisualizer(
      channel: MethodChannel('calls'),
    )
      ..addListener(
        fftCallback: (List<int> fftSamples) {
          setState(() => fft = fftSamples);
        },
        waveformCallback: (List<int> waveformSamples) {
          // Handle waveform data if needed
        },
      )
      ..activate(widget.id);
  }

  @override
  void dispose() {
    visualizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, fft);
  }
}
