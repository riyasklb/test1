import 'package:flutter/services.dart';

import 'package:test1/callbacks.dart';

class FlutterVisualizers {
  static const MethodChannel _channel =
      const MethodChannel('calls');

  static AudioVisualizer audioVisualizer() {
    return new AudioVisualizer(
      channel: _channel,
    );
  }
}
