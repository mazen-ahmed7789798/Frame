import 'package:flutter/material.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/Pages/search_results_pages.dart';
import 'package:frame/search/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:frame/Pages/error_page.dart';
import 'package:frame/widgets/navigation_button.dart';

class MobileBody extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final ErrorType? errorType;
  const MobileBody({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
    required this.errorType,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final provider = context.watch<SearchProvider>();

    final results = provider.results;
    final resultsLength = results.length;
    final query = provider.lastQuery;

    final List<Video> videos = provider.results.whereType<Video>().toList();

    const int pageSize = 2;

    final int pagesCount = (videos.length / pageSize).ceil();

    final List<SearchResultsPages> pages = [];

    for (int pageIndex = 0; pageIndex < pagesCount; pageIndex++) {
      final int start = pageIndex * pageSize;
      final int end = (start + pageSize).clamp(0, videos.length);

      pages.add(SearchResultsPages(videos.sublist(start, end)));
    }

    final safeCurrentPage = pagesCount == 0
        ? 0
        : currentPage.clamp(0, pagesCount - 1);

    return Scaffold(
      backgroundColor: Color(0xff0B0F13),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null && provider.error!.isNotEmpty
          ? ErrorPage(errorType: errorType!)
          : Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          '$resultsLength results for',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      Text('"$query"', style: TextStyle(color: primary)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: pages.isEmpty
                        ? const SizedBox()
                        : pages[safeCurrentPage],
                  ),
                  if (pagesCount > 0)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NavigationArrowButton(
                            icon: Icons.chevron_left,
                            tooltip: 'Previous page',
                            compact: true,
                            onPressed: safeCurrentPage > 0
                                ? () => onPageChanged(safeCurrentPage - 1)
                                : null,
                          ),
                          for (
                            int pageIndex = 0;
                            pageIndex < pagesCount;
                            pageIndex++
                          )
                            NavigationButton(
                              index: pageIndex,
                              currentPage: safeCurrentPage,
                              compact: true,
                              onPressed: () => onPageChanged(pageIndex),
                            ),
                          NavigationArrowButton(
                            icon: Icons.chevron_right,
                            tooltip: 'Next page',
                            compact: true,
                            onPressed: safeCurrentPage < pagesCount - 1
                                ? () => onPageChanged(safeCurrentPage + 1)
                                : null,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
