import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  const new({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget dot(int index) {
    final delay = index * 0.2;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = (_controller.value - delay) % 1.0;
        final y = value < 0.5
            ? -8 * (value / 0.5)
            : -8 * (1 - (value - 0.5) / 0.5);
        return Transform.translate(offset: Offset(0, y), child: child);
      },
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Color(0xff7ee7c6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        dot(0),
        const SizedBox(width: 6),
        dot(1),
        const SizedBox(width: 6),
        dot(2),
        const SizedBox(width: 6),
      ],
    );
  }
}
