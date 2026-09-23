import 'package:flutter/material.dart';

class GeneralErrorScreen extends StatefulWidget {
  final String errorMesage;
  const GeneralErrorScreen({super.key, required this.errorMesage});

  @override
  State<GeneralErrorScreen> createState() => _GeneralErrorScreenState();
}

class _GeneralErrorScreenState extends State<GeneralErrorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: Tween<double>(
              begin: 0.4,
              end: 0.6,
            ).animate(_animationController),
            child: Image.asset("images/warning.png", width: 180, height: 180),
          ),
        ],
      ),
    );
  }
}
