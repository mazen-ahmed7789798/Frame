import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/search/search_service.dart';
import 'package:frame/network/network_status_service.dart';

enum ErrorType { noInternetError, generalError }

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  Content? idSearchResult;
  List<Content> _results = [];
  bool _isLoading = false;
  String? _error;
  String? _lastQuery;
  ErrorType? errorType;
  List<Content> get results => _results;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get lastQuery => _lastQuery;
  Future<bool> hasInternet() async {
    final network = NetworkService();
    final report = await network.check();
    return report.hasInternet;
  }

  Future<void> searchByWord(
    String query, {
    SearchType? type,
    int? maxResults,
  }) async {
    _isLoading = true;
    _error = null;
    _lastQuery = query;
    notifyListeners();

    try {
      if (!await hasInternet()) {
        _error = "No internet connection";
        errorType = ErrorType.noInternetError;
        return;
      }

      _results = await _searchService.searchByWord(
        query,
        type: type,
        maxResults: maxResults,
      );
    } catch (e) {
      _error = e.toString();
      errorType = ErrorType.generalError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchById(String id) async {
    _isLoading = true;
    _error = null;
    idSearchResult = null;

    notifyListeners();

    try {
      if (!await hasInternet()) {
        _error = "No internet connection";
        errorType = ErrorType.noInternetError;

        return;
      }

      idSearchResult = await _searchService.searchById(id);
    } catch (e) {
      _error = e.toString();
      errorType = ErrorType.generalError;

      idSearchResult = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

void main() async {
  SearchProvider searchProvider = SearchProvider();
  await searchProvider.searchById("id");
}
