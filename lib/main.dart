import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'display_picture.dart';
import 'take_picture.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => DisplayPictureScreen(camera: firstCamera),
        '/camera': (context) => TakePictureScreen(camera: firstCamera),
      },
    ),
  );
}
