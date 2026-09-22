import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/widgets/video_cards/video_card.dart';

class SearchResultsPages extends StatelessWidget {
  final List<Content> cards;

  const SearchResultsPages(this.cards, {super.key});

  @override
  Widget build(BuildContext context) {
    final videos = cards.whereType<Video>().toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (videos.isEmpty) {
          return const SizedBox.shrink();
        }

        const cardSpacing = 10.0;
        const maxCardHeight = 250.0;

        final totalSpacing = math.min(
          cardSpacing * (videos.length - 1),
          constraints.maxHeight,
        );

        final availableCardHeight =
            math.max(0.0, constraints.maxHeight - totalSpacing) / videos.length;

        final cardHeight = constraints.maxWidth < 600
            ? availableCardHeight
            : math.min(availableCardHeight, maxCardHeight);

        if (constraints.maxWidth < 600) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < videos.length; index++)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: index < videos.length - 1 ? cardSpacing : 0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: VideoCard(video: videos[index]),
                  ),
                ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int index = 0; index < videos.length; index++)
              Padding(
                padding: EdgeInsets.only(
                  bottom: index < videos.length - 1 ? cardSpacing : 0,
                ),
                child: SizedBox(
                  height: cardHeight,
                  width: double.infinity,
                  child: VideoCard(video: videos[index]),
                ),
              ),
          ],
        );
      },
    );
  }
}
