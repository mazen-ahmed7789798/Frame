import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  final int index;
  final VoidCallback? onPressed;
  final int currentPage;
  final bool compact;

  const NavigationButton({
    required this.index,
    required this.onPressed,
    required this.currentPage,
    this.compact = false,
    super.key,
  });

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  static const Color accentColor = Color(0xFF1DBF9B);

  bool isHovered = false;

  bool get isCurrentPage => widget.currentPage == widget.index;

  @override
  Widget build(BuildContext context) {
    final size = widget.compact ? 32.0 : 40.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: size,
          height: size,
          child: Material(
            color: isCurrentPage
                ? accentColor.withValues(alpha: 0.12)
                : isHovered
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.compact ? 6 : 8),
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(widget.compact ? 6 : 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOutCubic,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isCurrentPage
                        ? accentColor
                        : isHovered
                        ? accentColor.withValues(alpha: 0.65)
                        : Colors.grey.withValues(alpha: 0.45),
                    width: isCurrentPage ? 1.8 : 1.2,
                  ),
                  borderRadius: BorderRadius.circular(widget.compact ? 6 : 8),
                ),
                child: Center(
                  child: Text(
                    '${widget.index + 1}',
                    style: TextStyle(
                      fontSize: widget.compact ? 12 : 14,
                      fontWeight: isCurrentPage || isHovered
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isCurrentPage || isHovered
                          ? accentColor
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
    final size = compact ? 32.0 : 40.0;

    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: compact ? 18 : 22),
        color: const Color(0xFF1DBF9B),
        disabledColor: Colors.white38,
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(compact ? 6 : 8),
          ),
        ),
      ),
    );
  }
}
