import 'package:flutter/services.dart';

import 'package:test1/callbacks.dart';

class FlutterVisualizers {
  static const MethodChannel _channel =
      const MethodChannel('fluttery_audio_visualizer');

  static AudioVisualizer audioVisualizer() {
    return new AudioVisualizer(
      channel: _channel,
    );
  }
}
