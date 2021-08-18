import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_api_video_player/VideoPlayer.dart';

class TestApiVideoPlayer extends StatefulWidget {
  @override
  _TestApiVideoPlayerState createState() => _TestApiVideoPlayerState();
  MethodChannel _channel = const MethodChannel('api_plugin');
  String inputData1;
  String dataModel1;
  String narrationVoice;
  String quality;
  String language;
  String narrationText;
  String secretKey;

  TestApiVideoPlayer(this.inputData1, this.dataModel1, this.narrationVoice,
      this.quality, this.language, this.narrationText, this.secretKey);

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
       widget.inputData1,
        widget.dataModel1,
        widget.narrationVoice,
        widget.quality,
        widget.language,
        widget.narrationText,
        widget.secretKey);
  }
}
