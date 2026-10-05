import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/search/search_service.dart';
import 'package:frame/network/network_status_service.dart';
import 'package:http/http.dart';
import 'package:frame/search/response.dart';

enum SearchStatus { loading, hasError, finished, notStarted }

enum ErrorType { noInternetError, generalError }

const _searchUnavailableMessage =
    'Search is temporarily unavailable. The request to the search API failed.';

String searchErrorMessage(Object error) {
  if (error is ClientException) {
    return _searchUnavailableMessage;
  }

  final text = error.toString();
  if (text.contains('ClientException') ||
      text.contains('NetworkError') ||
      text.contains('Failed to fetch')) {
    return _searchUnavailableMessage;
  }

  if (error is FormatException) {
    return 'Search returned an unexpected response.';
  }

  if (text.contains('Search request failed')) {
    return 'Search is temporarily unavailable. Please try again.';
  }

  return 'Something went wrong while searching.';
}

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  Content? idSearchResult;
  final SearchStatus _searchType = SearchStatus.notStarted;
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
      final response = await _searchService.searchByWord(
        query,
        type: type,
        maxResults: maxResults,
      );
      _results = response.data;
    } catch (e) {
      _error = searchErrorMessage(e);
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
      final serviceResult = await _searchService.searchById(id);
      idSearchResult = serviceResult.data;
      
    } catch (e) {
      _error = searchErrorMessage(e);
      _errorType = ErrorType.generalError;

      idSearchResult = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
