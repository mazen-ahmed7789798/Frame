import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final void Function(String query) onSearch;
  final TextEditingController controller;

  const MySearchBar({
    super.key,
    required this.onSearch,
    required this.controller,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late final FocusNode _focusNode;
  late final UndoHistoryController _undoHistoryController;

  bool isHidden = true;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode(canRequestFocus: true);
    _undoHistoryController = UndoHistoryController();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _undoHistoryController.dispose();
    super.dispose();
  }

  void _search() {
    final query = widget.controller.text.trim();

    if (query.isEmpty) return;

    widget.onSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Focus(
        focusNode: _focusNode,
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xff141A22),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _focusNode.hasFocus ? primary : Colors.black,
            ),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.search, size: 28),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    autofocus: true,
                    contextMenuBuilder: (context, editableTextState) {
                      final List<ContextMenuButtonItem> buttonsItems =
                          editableTextState.contextMenuButtonItems;
                      return AdaptiveTextSelectionToolbar.buttonItems(
                        buttonItems: buttonsItems,
                        anchors: editableTextState.contextMenuAnchors,
                      );
                    },
                    undoController: _undoHistoryController,
                    controller: widget.controller,
                    focusNode: FocusNode(canRequestFocus: false),
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        isHidden = value.isEmpty;
                      });
                    },
                    onSubmitted: (_) {
                      _search();
                    },
                    decoration: const InputDecoration(
                      hintText: "Search for videos",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),

              if (!isHidden)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  icon: Icon(Icons.clear, color: primary, size: 20),
                  onPressed: () {
                    widget.controller.clear();

                    setState(() {
                      isHidden = true;
                    });
                  },
                ),

              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                onPressed: _search,
                icon: Icon(Icons.arrow_forward, size: 28, color: primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
