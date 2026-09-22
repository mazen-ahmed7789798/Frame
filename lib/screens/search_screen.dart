import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:frame/screens/search_screens_bodys/desktop_body.dart';
import 'package:frame/screens/search_screens_bodys/mobile_body.dart';
import 'package:frame/screens/search_screens_bodys/tablet_body.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  final suggestions = ["Focus", "Deep Work", "Motivation"];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print("KK");
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile حقيقي
        if (!kIsWeb) {
          final shortestSide = MediaQuery.sizeOf(context).shortestSide;

          if (shortestSide < 600) {
            print("Mobile");
            return MobileBody(
              controller: _controller,
              suggestions: suggestions,
            );
          }
        }

        // Web + الأجهزة الأكبر
        if (constraints.maxWidth < 600) {
          print("Mobile");

          return MobileBody(controller: _controller, suggestions: suggestions);
        }

        if (constraints.maxWidth < 1024) {
          print("tablet");
          return TabletBody(controller: _controller, suggestions: suggestions);
        }
        print("Desktop");

        return DesktopBody(controller: _controller, suggestions: suggestions);
      },
    );
  }
}
