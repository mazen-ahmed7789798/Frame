import 'package:flutter/material.dart';
import 'package:frame/models/video_model.dart';
import 'package:go_router/go_router.dart';

class DesktopVideoCard extends StatelessWidget {
  final Video video;

  const DesktopVideoCard({super.key, required this.video});

  String formatDate(DateTime date) {
    return '${date.year}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: () {
        context.goNamed("watch", queryParameters: {"id": video.videoId});
      },
      borderRadius: BorderRadius.circular(8),

      child: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF0F141A),
          borderRadius: BorderRadius.circular(8),
        ),

        child: Row(
          children: [
            // =========================
            // Thumbnail
            // =========================
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    video.highThumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image_outlined),
                      );
                    },
                  ),

                  // Duration
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video.videoDuration,
                        style: TextStyle(
                          color: primary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // Information
            // =========================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video title
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        video.videoTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                    ),

                    const Spacer(flex: 9),

                    // Channel
                    Text(
                      video.channelTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),

                    const Spacer(flex: 5),

                    // Published date
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: formatDate(video.publishedAt)),
                          const TextSpan(text: " \u2022 "),
                          TextSpan(text: video.publishedWhileAgo),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
