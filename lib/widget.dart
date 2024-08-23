import 'package:flutter/material.dart';
import 'package:test1/Visualizers/BarVisualizer.dart';
import 'package:test1/methodcall.dart';
import 'package:test1/visualizer.dart';

class PlaySong extends StatefulWidget {
  @override
  _PlaySongState createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  int? playerID;
  final MethodCalls methodCalls = MethodCalls();
  List<int> waveData = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }





  Future<void> initPlatformState() async {
    int? sessionId;
    try {
      await methodCalls.playSong(); // Start playing the song
      sessionId = await methodCalls.getSessionId(); // Retrieve session ID
    } catch (e) {
      print('Error initializing platform state: $e');
      sessionId = null;
    }

    if (mounted) {
      setState(() {
        playerID = sessionId;
      });
    }
  }

  void updateWaveData(List<int> wave) {
    if (mounted) {
      setState(() {
        waveData = wave;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bar Visualizer'),
        ),
        body: playerID != null
            ? Visualizer(
                builder: (BuildContext context, List<int> wave) {
                  updateWaveData(wave);
                  return CustomPaint(
                    painter: BarVisualizer(
                      waveData: waveData,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blueAccent,
                    ),
                    child: Container(),
                  );
                },
                id: playerID!,
              )
            : Center(
                child: Text('No SessionID'),
              ),
      ),
    );
  }
}
