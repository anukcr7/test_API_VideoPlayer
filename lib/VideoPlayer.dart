import 'package:test_api_video_player/getAPIData.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoPlayer extends StatefulWidget {
  String inputData1;
  String dataModel1;
  String narrationVoice;
  String quality;
  String language;
  String narrationText;
  String secretKey;

  VideoPlayer(this.inputData1, this.dataModel1, this.narrationVoice,
      this.quality, this.language, this.narrationText, this.secretKey);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  String? video;
  void setupvideolink() async {
    getAPIData instance = getAPIData(
        widget.inputData1,
        widget.dataModel1,
        widget.narrationVoice,
        widget.quality,
        widget.language,
        widget.narrationText,
        widget.secretKey);
    await instance.getData();
    print('GOT VIDEO LINK: ${instance.myvideo}');
    setState(() {
      video = instance.myvideo!;
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(video!),
      );
    });
  }

  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    setupvideolink();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(000000),
            body: Stack(
              children: [
                video != null
                    ? Positioned.fill(
                        child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              height: 400,
                              width: double.infinity,
                              child: VisibilityDetector(
                                key: ObjectKey(flickManager),
                                onVisibilityChanged: (visibility) {
                                  if (visibility.visibleFraction == 0 &&
                                      this.mounted) {
                                    flickManager.flickControlManager!
                                        .autoPause();
                                  } else if (visibility.visibleFraction == 1) {
                                    flickManager.flickControlManager!
                                        .autoResume();
                                  }
                                },
                                child: Container(
                                  child: FlickVideoPlayer(
                                    flickManager: flickManager,
                                    flickVideoWithControls:
                                        FlickVideoWithControls(
                                      controls: FlickPortraitControls(),
                                    ),
                                    flickVideoWithControlsFullscreen:
                                        FlickVideoWithControls(
                                      controls: FlickLandscapeControls(),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ))
                    : Center(child: CircularProgressIndicator()),
              ],
            )));
  }
}
