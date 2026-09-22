import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final void Function(String query) onSearch;
  final TextEditingController controller;

  const MySearchBar({
    super.key,
    required this.onSearch,
    required this.controller,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  void _search() {
    final query = widget.controller.text.trim();

    if (query.isEmpty) return;

    widget.onSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    final bool hasText = widget.controller.text.isNotEmpty;

    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xff121A22),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: hasText
              ? primary.withValues(alpha: 0.9)
              : Colors.grey.shade800,
          width: hasText ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: hasText ? 0.18 : 0.08),
            blurRadius: hasText ? 18 : 8,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: Icon(
              Icons.search,
              size: 24,
              color: hasText ? primary : Colors.grey.shade500,
            ),
          ),

          Expanded(
            child: TextField(
              controller: widget.controller,
              textInputAction: TextInputAction.search,
              maxLines: 1,
              cursorColor: primary,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),

              onChanged: (_) {
                if (mounted) {
                  setState(() {});
                }
              },

              onSubmitted: (_) {
                _search();
              },

              decoration: InputDecoration(
                hintText: 'Search for videos',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          if (hasText)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              icon: Icon(Icons.clear, color: primary, size: 18),
              onPressed: () {
                widget.controller.clear();

                if (mounted) {
                  setState(() {});
                }
              },
            ),

          IconButton(
            padding: const EdgeInsets.only(right: 8, left: 4),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: _search,
            icon: Icon(Icons.arrow_forward, size: 24, color: primary),
          ),
        ],
      ),
    );
  }
}
