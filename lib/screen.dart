import 'package:flutter/material.dart';
import 'package:test1/Visualizers/LineVisualizer.dart';
import 'package:test1/methodcall.dart';
import 'package:test1/visualizer.dart';

class PlaySong extends StatefulWidget {
  @override
  _PlaySongState createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  int? playerID;
  final MethodCalls methodCalls = MethodCalls();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    int? sessionId;
    try {
      sessionId = await methodCalls.getSessionId(); // Retrieve session ID
      print('Session ID: $sessionId');
    } catch (e) {
      print('Error initializing platform state: $e');
    }

    if (sessionId != null && mounted) {
      setState(() {
        playerID = sessionId;
      });
    }
  }

  void togglePlayPause() async {
    if (isPlaying) {
      await methodCalls.pauseSong(); // Pause the song
    } else {
      await methodCalls.playSong(); // Play the song
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Line Visualizer'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            playerID != null && isPlaying
                ? Container(
                    height: 300,
                    width: 300,
                    color: Colors.red,
                    child: Visualizer(
                      builder: (BuildContext context, List<int> wave) {
                        return CustomPaint(
                          painter: LineVisualizer(
                            sessionId: playerID!,
                            waveData: wave,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blueAccent,
                          ),
                         
                        );
                      },
                      id: playerID!,
                    ),
                  )
                : const Center(
                    child: Text('No SessionID or Not Playing'),
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: togglePlayPause,
                  iconSize: 64.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
