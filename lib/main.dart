import 'package:flutter/material.dart';
import 'package:test1/screen.dart';
import 'package:test1/widget.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Visualizer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlaySong(),
    );
  }
}
