import 'package:flutter/material.dart';

import 'package:test1/widget.dart'; // Make sure this path is correct

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
