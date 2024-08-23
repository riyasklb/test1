// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:test1/Visualizers/LineVisualizer.dart';

// class PlaySong extends StatefulWidget {
//   @override
//   _PlaySongState createState() => _PlaySongState();
// }

// class _PlaySongState extends State<PlaySong> {
//   static const platform = MethodChannel('calls');
//   List<int> fftData = [];

//   @override
//   void initState() {
//     super.initState();
//     platform.setMethodCallHandler(_handleMethodCall);
//   }

//   Future<void> _handleMethodCall(MethodCall call) async {
//     if (call.method == 'updateVisualizer') {
//       setState(() {
//         fftData = List<int>.from(call.arguments);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Real-Time Equalizer'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (fftData.isNotEmpty)
//             Container(
//               height: 300,
//               width: 300,
//               color: Colors.red,
//               child: CustomPaint(
//                 painter: LineVisualizer(
//                   waveData: fftData,
//                   height: 300,
//                   width: 300,
//                   color: Colors.blueAccent,
//                   sessionId: 0, // dummy value as sessionId is not used in drawing
//                 ),
//               ),
//             ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.play_arrow),
//                 onPressed: () {
//                   // Add your play/pause functionality here
//                 },
//                 iconSize: 64.0,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
