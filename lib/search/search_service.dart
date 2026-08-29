import 'dart:convert';

import 'package:http/http.dart';

enum SearchType { video, all, channel, playlist }

class SearchService {
  Future<List<Map<String,dynamic>>> searchByWord(
    String query, {
    SearchType type = SearchType.all,
    int? maxResults,
  }) async {
    final uri = Uri(
      scheme: "https",
      host: "vh-prod-frame-api-main-50d2a0-740c016d.livemy.site",
      path: "/api/v1/search",
      queryParameters: {
        "q": query,
        "type": type.name,
        if (maxResults != null) "maxResults": maxResults.toString(),
      },
    );
    final response = await get(uri);
    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw const FormatException('Search response is not a list');
    }

    return decoded
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  // Future<Map<String,dynamic>> searchById (String id) {

  // }
}

void main() async {
  SearchService searchService = SearchService();
  print(await searchService.searchByWord("query"));
}
