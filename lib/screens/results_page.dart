import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/screens/results_screens_bodys/desktop_body.dart';
import 'package:frame/screens/results_screens_bodys/mobile_body.dart';
import 'package:frame/screens/results_screens_bodys/tablet_body.dart';
import 'package:frame/screens/search_results_pages.dart';
import 'package:frame/search/search_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatefulWidget {
  final int initialPage;

  const ResultsPage({super.key, this.initialPage = 0});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late int _currentPage = widget.initialPage;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) {
    _currentPage = currentPage;
  }

  @override
  void didUpdateWidget(covariant ResultsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialPage != widget.initialPage) {
      _currentPage = widget.initialPage;
    }
  }

  void _changePage(int page) {
    setState(() => currentPage = page);
    context.goNamed("results", queryParameters: {"page": "${page + 1}"});
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<SearchProvider>(); // private
    final primary = Theme.of(context).colorScheme.primary;
    String? error = _provider.error;
    bool isLoading = _provider.isLoading;
    final _results = _provider.results; // private
    final List<Video> _videos = _provider.results
        .whereType<Video>()
        .toList(); // private
    final _resultsLength = _results.length;
    final _lastQuery = _provider.lastQuery;
    const int pageSize = 2;
    final int pagesCount = (_videos.length / pageSize).ceil();
    final List<SearchResultsPages> pages = []; // private
    for (int pageIndex = 0; pageIndex < pagesCount; pageIndex++) {
      final int start = pageIndex * pageSize;
      final int end = (start + pageSize).clamp(0, _videos.length);

      pages.add(SearchResultsPages(_videos.sublist(start, end)));
    }
    return Title(
      color: const Color(0xFF7EE7C6),
      title: "Frame - Resutls",
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: primary,
          leading: IconButton(
            onPressed: () {
              context.goNamed("home");
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (!kIsWeb) {
              final shortestSide = MediaQuery.sizeOf(context).shortestSide;

              if (shortestSide < 600) {
                return MobileBody(
                  errorType: _provider.errorType,
                  currentPage: _currentPage,
                  onPageChanged: _changePage,
                );
              }
            }

            // Web + الأجهزة الأكبر:
            // نعتمد على عرض المساحة المتاحة.
            if (constraints.maxWidth < 600) {
              return MobileBody(
                errorType: _provider.errorType,
                currentPage: _currentPage,
                onPageChanged: _changePage,
              );
            } else if (constraints.maxWidth < 1024) {
              return TabletBody(
                errorType: _provider.errorType,

                currentPage: _currentPage,
                onPageChanged: _changePage,
                error: error,
                isLoading: isLoading,
                pagesCount: pagesCount,
                lastQuery: _lastQuery ?? '',
                resultsLength: _resultsLength,
                pages: pages,
              );
            } else {
              return DesktopBody(
                errorType: _provider.errorType,
                currentPage: _currentPage,
                onPageChanged: _changePage,
                error: error,
                isLoading: isLoading,
                pagesCount: pagesCount,
                lastQuery: _lastQuery ?? '',
                resultsLength: _resultsLength,
                pages: pages,
              );
            }
          },
        ),
      ),
    );
  }
}
