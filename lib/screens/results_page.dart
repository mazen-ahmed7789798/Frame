import "package:flutter/material.dart";
import 'package:frame/layout/app_layout.dart';
import 'package:frame/models/video_model.dart';
import 'package:frame/screens/error_page.dart';
import 'package:frame/screens/search_results_pages.dart';
import 'package:frame/search/search_provider.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();

    final lastQuery = provider.lastQuery;

    // نأخذ الـ Videos فقط قبل عمل الـ pagination
    final List<Video> videos = provider.results.whereType<Video>().toList();

    // عدد النتائج في الصفحة
    const int pageSize = 2;

    // عدد الصفحات
    final int pagesCount = (videos.length / pageSize).ceil();

    // إنشاء الصفحات
    final List<SearchResultsPages> pages = [];

    for (int pageIndex = 0; pageIndex < pagesCount; pageIndex++) {
      final int start = pageIndex * pageSize;

      final int end = (start + pageSize).clamp(0, videos.length);

      pages.add(SearchResultsPages(videos.sublist(start, end)));
    }

    // حماية في حالة تغير النتائج
    if (pagesCount == 0 && currentPage != 0) {
      currentPage = 0;
    } else if (currentPage >= pagesCount && pagesCount > 0) {
      currentPage = pagesCount - 1;
    }

    final padding = AppLayout.pagePadding(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F13),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F13),
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Frame",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
          ? ErrorPage(errorMessage: provider.error!)
          : Column(
              children: [
                SizedBox(height: padding),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppLayout.contentMaxWidth,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${videos.length} results for ",
                              style: const TextStyle(color: Colors.grey),
                            ),

                            TextSpan(
                              text: '"$lastQuery"',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 2),

                Expanded(
                  child: pages.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(padding),
                            child: Text(
                              "No results found for '$lastQuery'",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: AppLayout.contentMaxWidth,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: pages[currentPage],
                            ),
                          ),
                        ),
                ),

                // Pagination
                if (pagesCount > 1)
                  Padding(
                    padding: EdgeInsets.only(
                      left: padding,
                      right: padding,
                      bottom: 16,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Previous
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF181E23),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 36,
                            height: 36,
                            child: IconButton(
                              onPressed: currentPage > 0
                                  ? () {
                                      setState(() {
                                        currentPage--;
                                      });
                                    }
                                  : null,
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 16,
                                color: currentPage > 0
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                              ),
                            ),
                          ),

                          // Page numbers
                          for (int index = 0; index < pagesCount; index++)
                            _NavigationButton(index, () {
                              setState(() {
                                currentPage = index;
                              });
                            }, currentPage),

                          // Next
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF181E23),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 36,
                            height: 36,
                            child: IconButton(
                              onPressed: currentPage < pagesCount - 1
                                  ? () {
                                      setState(() {
                                        currentPage++;
                                      });
                                    }
                                  : null,
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: currentPage < pagesCount - 1
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final int index;
  final void Function()? onPressed;
  final int currentPage;

  const _NavigationButton(this.index, this.onPressed, this.currentPage);

  bool get isCurrentPage => currentPage == index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: isCurrentPage ? const Color(0xFF1DBF9B) : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Text(
          "${index + 1}",
          style: TextStyle(
            fontSize: 14,
            color: isCurrentPage ? const Color(0xFF1DBF9B) : Colors.white,
          ),
        ),
      ),
    );
  }
}
