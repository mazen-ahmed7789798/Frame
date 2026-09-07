import 'package:flutter/material.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/screens/Card.dart';

class SearchResultsPages extends StatelessWidget {
  final List<Content> cards;

  const SearchResultsPages(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    final videos = cards.whereType<Video>().toList();

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
