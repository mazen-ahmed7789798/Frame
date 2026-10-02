import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frame/widgets/loading_dots.dart';
import 'package:gif_view/gif_view.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  Timer? _timer;
  int _gifKey = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;

      setState(() {
        _gifKey++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 104,
              height: 104,
              child: GifView.asset(
                'images/No Wifi.gif',
                key: ValueKey(_gifKey),
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            ),
            const SizedBox(height: 8),
            const Text(
              'we’re trying to reconnect..',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            LoadingDots(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
