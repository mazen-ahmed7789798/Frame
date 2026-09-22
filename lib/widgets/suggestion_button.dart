import 'package:flutter/material.dart';

class SuggestionButton extends StatelessWidget {
  final void Function() onPressed;
  final String suggestionText;
  SuggestionButton({
    super.key,
    required this.onPressed,
    required this.suggestionText,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: () {
        onPressed;
      },
      child: Text(suggestionText, style: TextStyle(color: primary)),
    );
  }
}
