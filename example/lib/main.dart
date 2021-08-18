import 'package:flutter/material.dart';
import 'package:test_api_video_player/test_api_video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return TestApiVideoPlayer(
        "car1", "2", "female", "5", "en", "Hello%20there", "secret_key");
  }
}
