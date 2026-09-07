import 'package:flutter/material.dart';
import 'package:frame/layout/app_layout.dart';
import 'package:frame/screens/results_page.dart';
import 'package:provider/provider.dart';
import "package:frame/search/search_provider.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _suggestions = ['Focus', 'Deep Work', 'motivation'];

  late TextEditingController _controller;
  bool isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submitSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final provider = context.read<SearchProvider>();

    Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) => const ResultsPage())),
    );
    await provider.searchByWord(trimmed);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final compact = AppLayout.isCompact(context);
    final size = MediaQuery.sizeOf(context);
    final viewPadding = MediaQuery.viewPaddingOf(context);

    final outerPad = compact ? 8.0 : 24.0;
    final radius = compact ? 20.0 : 32.0;
    final titleSize = size.width < 360
        ? 28.0
        : compact
        ? 36.0
        : 56.0;
    final subtitleSize = compact ? 15.0 : 18.0;
    final searchHeight = compact ? 48.0 : 52.0;
    final hintSize = compact ? 15.0 : 16.0;

    return Scaffold(
      backgroundColor: const Color(0xFF070A0D),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(
          left: outerPad,
          right: outerPad,
          top: outerPad + viewPadding.top,
          bottom: outerPad + viewPadding.bottom,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: Color(0xFF0B0F13)),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: compact ? 1.15 : 0.9,
                    colors: [
                      primary.withValues(alpha: compact ? 0.12 : 0.16),
                      primary.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.35, 1.0],
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: compact ? 16 : 24,
                      vertical: 16,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'No',
                                      style: TextStyle(color: primary),
                                    ),
                                    const TextSpan(
                                      text: ' Distractions',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                ),
                              ),
                            ),
                            SizedBox(height: compact ? 8 : 12),
                            Text(
                              'Search for videos and watch without Distractions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF8B929A),
                                fontSize: subtitleSize,
                                fontWeight: FontWeight.w400,
                                height: 1.35,
                              ),
                            ),
                            SizedBox(height: compact ? 20 : 28),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 520),
                              child: Container(
                                width: double.infinity,
                                height: searchHeight,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF12181F),
                                  borderRadius: BorderRadius.circular(
                                    compact ? 14 : 16,
                                  ),
                                  border: Border.all(
                                    color: _focusNode.hasFocus
                                        ? primary
                                        : const Color(0xFF1A2129),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: compact ? 12 : 16,
                                      ),
                                      child: const Icon(
                                        Icons.search,
                                        color: Color(0xFF8B929A),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        controller: _controller,
                                        focusNode: _focusNode,
                                        autofocus: !compact,
                                        textInputAction: TextInputAction.search,
                                        style: TextStyle(
                                          fontSize: hintSize,
                                          color: Colors.white,
                                        ),
                                        onSubmitted: _submitSearch,
                                        onChanged: (value) {
                                          setState(() {
                                            isFocused = value.isNotEmpty;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Search for anything',
                                          hintStyle: TextStyle(
                                            fontSize: hintSize,
                                            color: const Color(0xFF8B929A),
                                          ),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: 14,
                                              ),
                                          isDense: true,
                                          suffixIcon: isFocused
                                              ? IconButton(
                                                  onPressed: () {
                                                    _controller.clear();
                                                    setState(() {
                                                      isFocused = false;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.clear,
                                                    color: primary,
                                                  ),
                                                )
                                              : null,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          _submitSearch(_controller.text),
                                      tooltip: 'Go to results',
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: compact ? 12 : 16),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  'Try: ',
                                  style: TextStyle(
                                    color: const Color(0xFF646971),
                                    fontWeight: FontWeight.w600,
                                    fontSize: compact ? 14 : 16,
                                  ),
                                ),
                                for (
                                  var i = 0;
                                  i < _suggestions.length;
                                  i++
                                ) ...[
                                  if (i > 0)
                                    Text(
                                      ', ',
                                      style: TextStyle(
                                        color: const Color(0xFF646971),
                                        fontSize: compact ? 14 : 16,
                                      ),
                                    ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _controller.text = _suggestions[i];
                                        setState(() {
                                          isFocused = true;
                                        });
                                        _submitSearch(_suggestions[i]);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: compact ? 8 : 4,
                                          horizontal: 2,
                                        ),
                                        child: Text(
                                          _suggestions[i],
                                          style: TextStyle(
                                            color: primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: compact ? 14 : 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
