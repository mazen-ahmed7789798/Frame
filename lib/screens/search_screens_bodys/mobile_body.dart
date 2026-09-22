import 'package:flutter/material.dart';
import 'package:frame/search/search_provider.dart';
import 'package:frame/widgets/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MobileBody extends StatefulWidget {
  final TextEditingController _controller;
  final List<String> suggestions;
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
                        provider.searchByWord(query);
                        context.pushNamed(
                          "results",
                          queryParameters: {"page": "1"},
                        );
                      },
                      controller: widget._controller,
                    ),
                  ),
                ),
                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Try:",
                      style: TextStyle(color: Color(0xff646971)),
                    ),
                    const SizedBox(width: 4),

                    for (final x in widget.suggestions)
                      GestureDetector(
                        onTap: () {
                          widget._controller.text = x;
                          widget._controller.selection =
                              TextSelection.collapsed(
                                offset: widget._controller.text.length,
                              );

                          setState(() {
                            isHidden = false;
                          });
                        },
                        child: Text(
                          widget.suggestions.last != x ? "$x," : x,
                          style: TextStyle(color: primary),
                        ),
                      ),
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
