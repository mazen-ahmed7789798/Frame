import 'package:flutter/material.dart';
import 'package:frame/Pages/error_page.dart';
import 'package:frame/Pages/search_results_pages.dart';
import 'package:frame/search/search_provider.dart';
import 'package:frame/widgets/navigation_button.dart';

class DesktopBody extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final int? pagesCount;
  final bool isLoading;
  final String? error;
  final int? resultsLength;
  final String lastQuery;
  final List<SearchResultsPages> pages;
  final ErrorType? errorType;
  const DesktopBody({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
    required this.pagesCount,
    required this.isLoading,
    required this.error,
    required this.lastQuery,
    required this.resultsLength,
    required this.pages,
    required this.errorType,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final safePagesCount = pagesCount ?? 0;
    final safeCurrentPage = safePagesCount == 0
        ? 0
        : currentPage.clamp(0, safePagesCount - 1);

    return Scaffold(
      backgroundColor: const Color(0xff0B0F13),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null && error!.isNotEmpty
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
                          '${resultsLength ?? 0} results for',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      Text('"$lastQuery"', style: TextStyle(color: primary)),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: pages.isEmpty
                              ? const SizedBox()
                              : pages[safeCurrentPage],
                        ),
                      ),
                    ),
                  ),
                  if (safePagesCount > 0)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NavigationArrowButton(
                            icon: Icons.chevron_left,
                            tooltip: 'Previous page',
                            onPressed: safeCurrentPage > 0
                                ? () => onPageChanged(safeCurrentPage - 1)
                                : null,
                          ),
                          for (
                            int pageIndex = 0;
                            pageIndex < safePagesCount;
                            pageIndex++
                          )
                            NavigationButton(
                              index: pageIndex,
                              currentPage: safeCurrentPage,
                              onPressed: () => onPageChanged(pageIndex),
                            ),
                          NavigationArrowButton(
                            icon: Icons.chevron_right,
                            tooltip: 'Next page',
                            onPressed: safeCurrentPage < safePagesCount - 1
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
