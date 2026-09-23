import 'package:flutter/material.dart';
import 'package:frame/search/search_provider.dart';
import 'package:frame/widgets/search_bar.dart';
import 'package:frame/widgets/suggestion_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TabletBody extends StatefulWidget {
  final TextEditingController controller;
  final List<SuggestionButton> suggestionButtons;
  TabletBody({
    super.key,
    required this.controller,
    required this.suggestionButtons,
  });

  @override
  State<TabletBody> createState() => _TabletBodyState();
}

class _TabletBodyState extends State<TabletBody> {
  bool isHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Distractions",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                const SizedBox(
                  child: Text(
                    "Search for videos and watch without Distractions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 520,
                    height: 46,
                    child: MySearchBar(
                      controller: widget.controller,
                      onSearch: (query) {
                        context.goNamed(
                          "results",
                          pathParameters: {"q": query},
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
                      index < widget.suggestionButtons.length;
                      index++
                    ) ...[
                      widget.suggestionButtons[index],
                      if (index < widget.suggestionButtons.length - 1)
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
