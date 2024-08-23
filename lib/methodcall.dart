import 'package:flutter/services.dart';

class MethodCalls {
  static const MethodChannel _channel = MethodChannel('calls');

  Future<void> playSong() async {
    try {
      await _channel.invokeMethod('playSong');
    } on PlatformException catch (e) {
      print("Failed to play song: '${e.message}'.");
    }
  }

  Future<int?> getSessionId() async {
    try {
      final int? sessionId = await _channel.invokeMethod('getSessionID');
      return sessionId;
    } on PlatformException catch (e) {
      print("Failed to get session ID: '${e.message}'.");
      return null;
    }
  }
}
