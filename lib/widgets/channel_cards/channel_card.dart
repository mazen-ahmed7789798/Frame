import 'package:flutter/material.dart';
import 'package:frame/models/channel_model.dart';

class ChannelCard extends StatelessWidget {
  final Channel channel;
  const new({required this.channel, super.key});

  @override
  Widget build(BuildContext context) {
    print("playerList: ${channel.channelTitle}");

    return const Placeholder();
  }
}
