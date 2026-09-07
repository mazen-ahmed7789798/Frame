import "package:flutter/material.dart";
import "package:frame/layout/app_layout.dart";
import "package:frame/models/video_model.dart";
import "package:youtube_player_iframe/youtube_player_iframe.dart";

class VideoPlayerPage extends StatefulWidget {
  final Video video;

  const VideoPlayerPage({super.key, required this.video});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.video.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compact = AppLayout.isCompact(context);
    final padding = AppLayout.pagePadding(context);
    final titleSize = compact ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F13),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F13),
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: compact
            ? Text(
                widget.video.videoTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxPlayerWidth = compact
                ? constraints.maxWidth
                : AppLayout.contentMaxWidth;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: compact ? 16 : 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (compact ? 32 : 48),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxPlayerWidth),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!compact) ...[
                          Text(
                            widget.video.videoTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: titleSize,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            compact ? 12 : 16,
                          ),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: YoutubePlayer(controller: _controller),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
