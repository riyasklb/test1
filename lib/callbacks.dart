import 'package:flutter/services.dart';

typedef void FftCallback(List<int> fftSamples);
typedef void WaveformCallback(List<int> waveformSamples);

class AudioVisualizer {

  final MethodChannel channel;
  final Set<FftCallback> _fftCallbacks = <FftCallback>{};
  final Set<WaveformCallback> _waveformCallbacks = <WaveformCallback>{};

  AudioVisualizer({required this.channel}) {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onFftVisualization':
        List<int> fftSamples = List<int>.from(call.arguments['fft']);
        for (var callback in _fftCallbacks) {
          callback(fftSamples);
        }
        break;
      case 'onWaveformVisualization':
        List<int> waveformSamples = List<int>.from(call.arguments['waveform']);
        for (var callback in _waveformCallbacks) {
          callback(waveformSamples);
        }
        break;
      default:
        throw UnimplementedError('${call.method} is not implemented for audio visualization channel.');
    }
  }

  void activate(int sessionID) {
    channel.invokeMethod('audiovisualizer/activate_visualizer', {"sessionID": sessionID});
  }

  void deactivate() {
    channel.invokeMethod('audiovisualizer/deactivate_visualizer');
  }

  void dispose() {
    deactivate();
    _fftCallbacks.clear();
    _waveformCallbacks.clear();
  }

  void addListener({
    required FftCallback fftCallback,
    required WaveformCallback waveformCallback,
  }) {
    _fftCallbacks.add(fftCallback);
    _waveformCallbacks.add(waveformCallback);
  }

  void removeListener({
    required FftCallback fftCallback,
    required WaveformCallback waveformCallback,
  }) {
    _fftCallbacks.remove(fftCallback);
    _waveformCallbacks.remove(waveformCallback);
  }
}
