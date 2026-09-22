import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final int index;
  final void Function()? onPressed;
  final int currentPage;
  final bool compact;

  const NavigationButton({
    required this.index,
    required this.onPressed,
    required this.currentPage,
    this.compact = false,
    super.key,
  });

  bool get isCurrentPage => currentPage == index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(compact ? 2 : 4),
      width: compact ? 32 : 40,
      height: compact ? 32 : 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: isCurrentPage ? const Color(0xFF1DBF9B) : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(compact ? 6 : 8),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Text(
          "${index + 1}",
          style: TextStyle(
            fontSize: compact ? 12 : 14,
            color: isCurrentPage ? const Color(0xFF1DBF9B) : Colors.white,
          ),
        ),
      ),
    );
  }
}

class NavigationArrowButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool compact;

  const NavigationArrowButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: compact ? 32 : 40,
      height: compact ? 32 : 40,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: Icon(icon),
        color: const Color(0xFF1DBF9B),
        disabledColor: Colors.white38,
      ),
    );
  }
}
