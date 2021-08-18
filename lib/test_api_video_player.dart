import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_api_video_player/VideoPlayer.dart';

class TestApiVideoPlayer extends StatefulWidget {
  @override
  _TestApiVideoPlayerState createState() => _TestApiVideoPlayerState();
  MethodChannel _channel = const MethodChannel('api_plugin');
  String x;
  String y;

  TestApiVideoPlayer(this.x, this.y);

  static const MethodChannel _chanel = const MethodChannel('api_plugin');

  static Future<String> get platformVersion async {
    final String version = await _chanel.invokeMethod('getPlatformVersion');
    return version;
  }
}

class _TestApiVideoPlayerState extends State<TestApiVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(
        "car1", "2", "female", "5", "en", "Hello%20there", "secret_key");
  }
}
