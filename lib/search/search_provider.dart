import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:frame/models/content_model.dart';
import 'package:frame/search/search_service.dart';
import 'package:frame/network/network_status_service.dart';
import 'package:http/http.dart';

enum SearchStatus { loading, hasError, finished, notStarted }

enum ErrorType { noInternetError, generalError }

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService = SearchService();

  Content? idSearchResult;

  final SearchStatus _searchType = SearchStatus.notStarted;

  SearchStatus get searchType => _searchType;

  List<Content> _results = [];

  bool _isLoading = false;

  String? _error;

  String? _lastQuery;

  ErrorType? _errorType;

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

  Future<void> searchByWord(
    String query, {
    SearchType? type = SearchType.video,
    int? maxResults,
  }) async {
    await Future<void>.delayed(Duration.zero);

    _isLoading = true;
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

      if (!response.success) {
        _error = response.message;
        _errorType = ErrorType.generalError;
        _results = [];
        return;
      }

      _results = response.data;
    } catch (e) {
      _error = (e).toString();
      _errorType = ErrorType.generalError;
      _results = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchById(String id) async {
    _isLoading = true;
    _error = null;
    _errorType = null;
    idSearchResult = null;

    notifyListeners();

    if (!await hasInternet()) {
      _error = "No internet connection";
      _errorType = ErrorType.noInternetError;
      _isLoading = false;

      notifyListeners();
      return;
    }

    try {
      final serviceResult = await _searchService.searchById(id);

      if (!serviceResult.success) {
        _error = serviceResult.message;
        _errorType = ErrorType.generalError;
        idSearchResult = null;
        return;
      }

      idSearchResult = serviceResult.data;
    } catch (e) {
      _error = (e).toString();
      _errorType = ErrorType.generalError;
      idSearchResult = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
