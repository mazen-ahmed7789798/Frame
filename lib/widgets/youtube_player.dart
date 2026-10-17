import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frame/auth/auth_service.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/video_progress/video_progress_service.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MyYoutubePlayer extends StatefulWidget {
  final Video video;

  const MyYoutubePlayer({super.key, required this.video});

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  late final YoutubePlayerController controller;
  PlayerState? playerState;
  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController.fromVideoId(
      videoId: widget.video.videoId,
      autoPlay: true,
      startSeconds: widget.video.position,
    );

    Timer.periodic(const Duration(seconds: 4), (_) async {
      final position = await controller.currentTime;
      if (playerState != PlayerState.paused &&
          playerState != PlayerState.ended) {
        if (AuthService().getCurrentUserAccessToken() != null) {
          VideoProgressService().saveVideoProgress(
            videoId: widget.video.videoId,
            position: position,
          );
        }
      }
    });

    controller.listen((event) async {
      playerState = event.playerState;
      if (event.playerState == PlayerState.paused) {
        final position = await controller.currentTime;
        VideoProgressService().saveVideoProgress(
          videoId: widget.video.videoId,
          position: position,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        YoutubePlayerScaffold(
          controller: controller,
          builder: (context, player) => player,
        ),
      ],
    );
  }
}
