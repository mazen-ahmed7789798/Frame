import 'package:flutter/material.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/widgets/video_cards/desktop_video_card.dart';
import 'package:frame/widgets/video_cards/mobile_video_card.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileVideoCard(video: video);
        } else {
          return DesktopVideoCard(video: video);
        }
      },
    );
  }
}
