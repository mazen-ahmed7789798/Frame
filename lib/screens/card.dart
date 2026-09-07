import "package:flutter/material.dart";
import "package:frame/layout/app_layout.dart";
import "package:frame/screens/video_player_page.dart";
import "package:frame/models/video_model.dart";

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard(this.video, {super.key});

  String formatDate(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, "0")}/${date.day.toString().padLeft(2, "0")}";
  }

  Widget _thumbnail({required double width, required double height}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Image.network(
            video.highThumbnail,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              video.videoDuration,
              style: const TextStyle(color: Color(0xFF7EE7C6), fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _info({required bool compact}) {
    return Padding(
      padding: EdgeInsets.only(
        left: compact ? 0 : 16,
        top: compact ? 12 : 20,
        right: compact ? 0 : 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.videoTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
              fontSize: compact ? 18 : 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            video.channelTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
              fontSize: compact ? 14 : 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formatDate(video.publishedAt),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
              fontSize: compact ? 14 : 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = AppLayout.isCompact(context);
    final padding = AppLayout.pagePadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFF0F141A),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerPage(video: video),
              ),
            );
          },
          hoverColor: const Color(0xFF0F141A),
          borderRadius: BorderRadius.circular(4),
          child: Card(
            color: const Color(0xFF0F141A),
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (compact) {
                  final thumbWidth = constraints.maxWidth;
                  final thumbHeight = thumbWidth * 9 / 16;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _thumbnail(width: thumbWidth, height: thumbHeight),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _info(compact: true),
                      ),
                    ],
                  );
                }

                final thumbWidth = constraints.maxWidth < 720 ? 220.0 : 360.0;
                final thumbHeight = thumbWidth * 9 / 16;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _thumbnail(width: thumbWidth, height: thumbHeight),
                    Expanded(child: _info(compact: false)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
