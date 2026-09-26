import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import 'network_status_service.dart';

class NetworkProvider extends ChangeNotifier {
  final NetworkService _networkService;

  StreamSubscription<NetworkReport>? _subscription;

  NetworkReport? _report;

  NetworkProvider(this._networkService) {
    _listenToNetwork();
  }

  // ─────────────────────────────────────────────
  // Current report
  // ─────────────────────────────────────────────

  NetworkReport? get report => _report;

  // ─────────────────────────────────────────────
  // Network state
  // ─────────────────────────────────────────────

  bool get hasNetwork => _report?.hasNetwork ?? false;

  bool get hasInternet => _report?.hasInternet ?? false;

  bool get isOffline => _report?.isOffline ?? true;

  // ─────────────────────────────────────────────
  // Connection type
  // ─────────────────────────────────────────────

  bool get isWifi => _report?.isWifi ?? false;

  bool get isMobile => _report?.isMobile ?? false;

  bool get isEthernet => _report?.isEthernet ?? false;

  List<ConnectivityResult> get connectionTypes =>
      _report?.connectionTypes ?? const [];

  // ─────────────────────────────────────────────
  // Connection quality
  // ─────────────────────────────────────────────

  NetworkQuality get quality => _report?.quality ?? NetworkQuality.unknown;

  int? get latency => _report?.latency;

  // ─────────────────────────────────────────────
  // Listening
  // ─────────────────────────────────────────────

  void _listenToNetwork() {
    _subscription = _networkService.onNetworkChanged.listen((report) {
      _report = report;
      notifyListeners();
    });
  }

  // ─────────────────────────────────────────────
  // Dispose
  // ─────────────────────────────────────────────

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
