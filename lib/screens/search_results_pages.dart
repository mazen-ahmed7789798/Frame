import 'package:flutter/material.dart';
import 'package:frame/layout/app_layout.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/screens/card.dart';

class SearchResultsPages extends StatelessWidget {
  final List<Content> cards;

  const SearchResultsPages(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    final videos = cards.whereType<Video>().toList();
    final compact = AppLayout.isCompact(context);

    if (compact) {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: videos.length,
        itemBuilder: (context, index) => VideoCard(videos[index]),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight / videos.length;

        return Column(
          children: [
            for (final video in videos)
              SizedBox(
                height: cardHeight,
                width: double.infinity,
                child: VideoCard(video),
              ),
          ],
        );
      },
    );
  }
}
