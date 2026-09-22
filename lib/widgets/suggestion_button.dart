import 'package:flutter/material.dart';

class SuggestionButton extends StatelessWidget {
  final String suggestionText;
  final TextEditingController controller;

  const SuggestionButton({
    super.key,
    required this.suggestionText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () {
        controller.text = suggestionText;
        controller.selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
      },
      child: Text(
        suggestionText,
        style: TextStyle(color: primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}
