import 'package:flutter/material.dart';
import 'package:frame/screens/results_page.dart';
import 'package:provider/provider.dart';
import "package:frame/search/search_provider.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    return Scaffold(
      backgroundColor: const Color(0xff12181F),
      body: Center(
        child: Container(
          width: 700,
          height: 400,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No",
                    style: TextStyle(
                      fontSize: 48,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Distractions",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const Text(
                "Search for content and consume without Distractions",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),

              const SizedBox(height: 18),

              Container(
                width: 460,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xff12181F),
                  border: Border.all(
                    color: _focusNode.hasFocus
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(Icons.search),
                    ),

                    const SizedBox(width: 8),
                    // Search Feild
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: true,
                        onSubmitted: (value) async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ResultsPage()),
                            ),
                          );
                          await provider.searchByWord(value);
                        },
                        onChanged: (value) {
                          setState(() {
                            isFocused = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search for anything",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),

                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),

                          isDense: true,

                          // زر المسح داخل حقل البحث
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),

                    // Results Navigation Button
                    IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ResultsPage()),
                          ),
                        );
                        await provider.searchByWord(_controller.text);
                      },
                      tooltip: "Go to results",
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
