import 'package:flutter/material.dart';
import 'package:frame/search/search_provider.dart';
import 'package:frame/widgets/search_bar.dart';
import 'package:frame/widgets/suggestion_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MobileBody extends StatefulWidget {
  final TextEditingController _controller;
  final List<SuggestionButton> suggestions;
  const MobileBody({
    super.key,
    required this._controller,
    required this.suggestions,
  });

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
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
                      TextSpan(
                        text: "No ",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                      TextSpan(
                        text: "Distractions",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Search for videos and watch without Distractions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: MySearchBar(
                      onSearch: (query) {
                        context.goNamed(
                          "results",
                          queryParameters: {"q": query},
                        );
                      },
                      controller: widget._controller,
                    ),
                  ),
                ),
                SizedBox(height: 12),

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
