import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/utils/app_constants.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String flickId;
  final String fromWhere;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.flickId,
    required this.fromWhere,
  });

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    context
        .read<FlicksController>()
        .isWatchHistoryClickedFn(context: context, id: widget.flickId);

    // Set orientation to landscape at the start
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Initialize the correct controller based on the video source
    _controller = widget.fromWhere == "network"
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.file(File(widget.videoUrl));

    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    }).catchError((e) {
      debugPrint('Error occurred during upload: $e ');
    });

    // Initialize Chewie controller
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
      allowPlaybackSpeedChanging: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppConstants.appPrimaryColor,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(
                      _controller,
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
          Chewie(
            controller: _chewieController,
          ),
          Positioned(
            left: 20,
            top: 20,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                radius: 25,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
