import "package:flutter/material.dart";
import "package:frame/models/channel_model.dart";
import "package:frame/models/content_model.dart";
import "package:frame/models/playlist_model.dart";
import "package:frame/models/video_model.dart";
import "package:frame/widgets/channel_cards/channel_card.dart";
import "package:frame/widgets/playlist_cards/playlist_card.dart";
import "package:frame/widgets/video_cards/video_card.dart";

class ContentCard extends StatelessWidget {
  final Content content;

  const ContentCard({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    if (content is Video) {
      return VideoCard(video: content as Video);
    } else if (content is Playlist) {
      return PlaylistCard(playlist: content as Playlist);
    } else if (content is Channel) {
      return ChannelCard(channel: content as Channel);
    }

    throw UnsupportedError("Unsupported content type: ${content.runtimeType}");
  }
}
