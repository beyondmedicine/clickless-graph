import 'package:clickless_graph/face/model/face_marker.dart';
import 'package:clickless_graph/face/model/face_side.dart';
import 'package:clickless_graph/face/widget/face_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FaceWidgetPreview1App());
}

final class FaceWidgetPreview1App extends StatelessWidget {
  const FaceWidgetPreview1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FaceWidget(
              side: FaceSide.right,
              markers: _sampleMarkers,
              markerBuilder: (context, marker) {
                final score = marker.value;

                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: [
                      Colors.green,
                      Colors.lime,
                      Colors.yellow,
                      Colors.orange,
                      Colors.deepOrange,
                      Colors.red,
                    ][score ~/ 2],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '$score점',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

const _sampleMarkers = <FaceMarker<int>>[
  FaceMarker(side: FaceSide.left, position: (x: 0.5, y: 0.5), value: 10),
  FaceMarker(side: FaceSide.right, position: (x: 0.5, y: 0.5), value: 10),
  FaceMarker(side: FaceSide.right, position: (x: 0.2, y: 0.3), value: 5),
  FaceMarker(side: FaceSide.right, position: (x: 0.1, y: 0.9), value: 3),
];
