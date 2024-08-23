import 'package:flutter/services.dart';

class MethodCalls {
  static const MethodChannel _channel = MethodChannel('calls');

  Future<int?> getSessionId() async {
    final sessionId = await _channel.invokeMethod<int>('getSessionID');
    return sessionId;
  }

  Future<void> playSong() async {
    await _channel.invokeMethod('playSong');
  }

  Future<void> pauseSong() async {
    await _channel.invokeMethod('pauseSong');
  }

  Future<void> activateVisualizer(int sessionId) async {
    await _channel.invokeMethod('audiovisualizer/activate_visualizer', {"sessionID": sessionId});
  }

  Future<void> deactivateVisualizer() async {
    await _channel.invokeMethod('audiovisualizer/deactivate_visualizer');
  }
}
