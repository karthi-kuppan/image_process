import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const DisplayPictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  static const platform = const MethodChannel('com.mine.opencv/image');

  Map data = {};

  // Get battery level.
  String _openCVVersion = 'Unknown version';

  Future<void> _getOpenCVVersion() async {
    String openCVVersion;
    try {
      final String result = await platform.invokeMethod('getOpenCVVersion');
      openCVVersion = '$result';
    } on PlatformException catch (e) {
      openCVVersion = "Failed to get opencv version: '${e.message}'.";
    }

    setState(() {
      _openCVVersion = openCVVersion;
    });
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: _bodyContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () {
          // If the picture was taken, display it on a new screen.
          Navigator.pushReplacementNamed(context, '/camera');
        },
      ),
    );
  }

  Widget _bodyContent () {
    if(data == null) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Get OpenCV Version'),
              onPressed: _getOpenCVVersion,
            ),
            Text(_openCVVersion),
          ],
        );
    } else {
      if (data['path'] == null) {
        return Text('No picture taken');
      } else {
        return Image.file(File(data['path']));
      }
    }
  }
}
