// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:frame/search/search_provider.dart';
import 'package:frame/widgets/search_bar.dart';
import 'package:frame/widgets/suggestion_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DesktopBody extends StatefulWidget {
  final TextEditingController controller;
  final List<SuggestionButton> suggestions;
  DesktopBody({super.key, required this.controller, required this.suggestions});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  bool isHidden = false;
  bool isFocused = false;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    final Color primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.65,
                colors: [
                  primary.withValues(alpha: 0.16),
                  primary.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.35, 1.0],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "No ",
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Distractions",
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                const SizedBox(
                  // width: 400,
                  child: Text(
                    "Search for videos and watch without Distractions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 520,
                    height: 46,
                    child: MySearchBar(
                      controller: widget.controller,
                      onSearch: (query) {
                        provider.searchByWord(query);
                        context.pushNamed(
                          "results",
                          queryParameters: {"page": "1"},
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 4),

                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    const Text(
                      "Try:",
                      style: TextStyle(
                        color: Color(0xff646971),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    for (
                      int index = 0;
                      index < widget.suggestions.length;
                      index++
                    ) ...[
                      widget.suggestions[index],
                      if (index < widget.suggestions.length - 1)
                        const Text(
                          ",",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
