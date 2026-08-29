import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 56,
                  color: colors.primary,
                ),
              ),
              Text(
                " Distractions",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 56,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Text(
            "Search for Content and consume without distractions",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF9BA3AF),
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 24),

          Container(
            width: 560,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF141A22),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Icon(Icons.search, size: 26, color: Color(0xFFE6ECEF)),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search for anything",
                      hintStyle: TextStyle(
                        color: Color(0xFFE6ECEF),
                        fontSize: 18,
                        fontWeight: FontWeight(200),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                  
                    tooltip: "Go to Results",
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
