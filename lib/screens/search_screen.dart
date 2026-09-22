import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:frame/screens/search_screens_bodys/desktop_body.dart';
import 'package:frame/screens/search_screens_bodys/mobile_body.dart';
import 'package:frame/screens/search_screens_bodys/tablet_body.dart';
import 'package:frame/widgets/suggestion_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  List<String> _suggestionsText = ["Focus", "Deep Work", "Motivation"];
  List<SuggestionButton> get suggestionButtons {
    List<SuggestionButton> buttons = [];
    for (String x in _suggestionsText) {
      buttons.add(
        SuggestionButton(
          suggestionText: x,
          controller: _controller,
        ),
      );
    }
    return buttons;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile حقيقي
        if (!kIsWeb) {
          final shortestSide = MediaQuery.sizeOf(context).shortestSide;

          if (shortestSide < 600) {
            debugPrint("Mobile");
            return MobileBody(
              controller: _controller,
              suggestions: suggestionButtons,
            );
          }
        }

        // Web + الأجهزة الأكبر
        if (constraints.maxWidth < 600) {
          debugPrint("Mobile");

          return MobileBody(
            controller: _controller,
            suggestions: suggestionButtons,
          );
        }

        if (constraints.maxWidth < 1024) {
          debugPrint("tablet");

          return TabletBody(
            controller: _controller,
            suggestionButtons: suggestionButtons,
          );
        }
        debugPrint("desktop");

        return DesktopBody(
          controller: _controller,
          suggestions: suggestionButtons,
        );
      },
    );
  }
}
