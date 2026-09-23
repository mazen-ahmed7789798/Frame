import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/search/search_service.dart';
import 'package:frame/network/network_status_service.dart';

enum SearchStatus { loading, hasError, finished, notStarted }

enum ErrorType { noInternetError, generalError }

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  Content? idSearchResult;
  SearchStatus _searchType = SearchStatus.notStarted;
  List<Content> _results = [];
  bool _isLoading = false;
  String? _error;
  String? _lastQuery;
  ErrorType? _errorType;

  SearchStatus get seearchType => _searchType;
  ErrorType? get errorType => _errorType;
  List<Content> get results => _results;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get lastQuery => _lastQuery;
  Future<bool> hasInternet() async {
    final network = NetworkService();
    final report = await network.check();
    return report.hasInternet;
  }

  // Search By Word
  Future<void> searchByWord(
    String query, { // Search Query = Search Word
    SearchType? type = SearchType.video, // Search Type = video
    int? maxResults,
  }) async {
    await Future<void>.delayed(Duration.zero);
    _isLoading = true;
    _error = null;
    _lastQuery = query;

    notifyListeners();
    if (!await hasInternet()) {
      _error = "No internet connection";
      _errorType = ErrorType.noInternetError;
      _isLoading = false;
      notifyListeners();
      return;
    }
    try {
      _results = await _searchService.searchByWord(
        query,
        type: type,
        maxResults: maxResults,
      );
    } catch (e) {
      _error = e.toString();
      _errorType = ErrorType.generalError;
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
    if (!await hasInternet()) {
      _error = "No internet connection";
      _errorType = ErrorType.noInternetError;
      _isLoading = false;
      return;
    }
    try {
      idSearchResult = await _searchService.searchById(id);
    } catch (e) {
      _error = e.toString();
      _errorType = ErrorType.generalError;

      idSearchResult = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
