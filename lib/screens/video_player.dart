import 'package:flutter/material.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/screens/error_page.dart';
import 'package:frame/search/search_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;

  const VideoPlayer({super.key, required this.videoId});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final YoutubePlayerController youtubePlayerController;
  late final YoutubePlayer youtubePlayer;
  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: YoutubePlayerParams(
        strictRelatedVideos: false,
        showVideoAnnotations: false,
        color: "green",
      ),
    );
    youtubePlayer = YoutubePlayer(controller: youtubePlayerController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SearchProvider>().searchById(widget.videoId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    double currentWidth = MediaQuery.sizeOf(context).width;
    final provider = context.watch<SearchProvider>();
    final Video? selectedVideo = provider.idSearchResult is Video
        ? provider.idSearchResult as Video
        : null;

    return Title(
      title: "Frame - ${selectedVideo?.videoTitle ?? "Video"}",
      color: const Color(0xFF7EE7C6),

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go("/results");
            },
            icon: const Icon(Icons.arrow_back),
          ),
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          centerTitle: true,
          title: currentWidth < 600
              ? selectedVideo != null
                    ? Text(
                        selectedVideo.videoTitle,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )
                    : null
              : null,
        ),
        body: provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : provider.error != null
            ? ErrorPage(errorType: provider.errorType!)
            : selectedVideo == null
            ? const Center(child: Text("Video not found"))
            : LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          currentWidth > 600 ? selectedVideo.videoTitle : "",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 960,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: youtubePlayer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
