import 'dart:async';

import 'package:async/async.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum NetworkQuality {
  excellent,
  good,
  fair,
  poor,
  unavailable,
  unknown,
}

class NetworkReport {
  final List<ConnectivityResult> connectionTypes;
  final bool hasNetwork;
  final bool hasInternet;
  final int? latency;
  final NetworkQuality quality;

  const NetworkReport({
    required this.connectionTypes,
    required this.hasNetwork,
    required this.hasInternet,
    this.latency,
    required this.quality,
  });

  bool get isWifi =>
      connectionTypes.contains(ConnectivityResult.wifi);

  bool get isMobile =>
      connectionTypes.contains(ConnectivityResult.mobile);

  bool get isEthernet =>
      connectionTypes.contains(ConnectivityResult.ethernet);

  bool get isOffline =>
      !hasNetwork || !hasInternet;

  @override
  String toString() {
    return 'NetworkReport('
        'connectionTypes: $connectionTypes, '
        'hasNetwork: $hasNetwork, '
        'hasInternet: $hasInternet, '
        'latency: ${latency}ms, '
        'quality: $quality'
        ')';
  }
}

class NetworkService {
  final Connectivity _connectivity;
  final InternetConnection _internetConnection;

  NetworkService({
    Connectivity? connectivity,
    InternetConnection? internetConnection,
  })  : _connectivity = connectivity ?? Connectivity(),
        _internetConnection =
            internetConnection ?? InternetConnection();

  Future<NetworkReport> check() async {
    final connectionTypes =
        await _connectivity.checkConnectivity();

    final hasNetwork =
        connectionTypes.isNotEmpty &&
        !connectionTypes.every(
          (result) => result == ConnectivityResult.none,
        );

    final hasInternet =
        await _internetConnection.hasInternetAccess;

    int? latency;

    if (hasInternet) {
      latency = await _measureLatency();
    }

    final quality = _calculateQuality(
      hasNetwork: hasNetwork,
      hasInternet: hasInternet,
      latency: latency,
    );

    return NetworkReport(
      connectionTypes: connectionTypes,
      hasNetwork: hasNetwork,
      hasInternet: hasInternet,
      latency: latency,
      quality: quality,
    );
  }

  Stream<NetworkReport> get onNetworkChanged async* {
    // أول حالة عند تشغيل التطبيق.
    yield await check();

    final stream = StreamGroup.merge([
      _connectivity.onConnectivityChanged,
      _internetConnection.onStatusChange,
    ]);

    await for (final _ in stream) {
      yield await check();
    }
  }

  Future<int?> _measureLatency() async {
    const attempts = 3;
    final values = <int>[];

    for (var i = 0; i < attempts; i++) {
      try {
        final stopwatch = Stopwatch()..start();

        final hasInternet =
            await _internetConnection.hasInternetAccess;

        stopwatch.stop();

        if (hasInternet) {
          values.add(stopwatch.elapsedMilliseconds);
        }
      } catch (_) {}
    }

    if (values.isEmpty) {
      return null;
    }

    final average =
        values.reduce((a, b) => a + b) / values.length;

    return average.round();
  }

  NetworkQuality _calculateQuality({
    required bool hasNetwork,
    required bool hasInternet,
    required int? latency,
  }) {
    if (!hasNetwork || !hasInternet) {
      return NetworkQuality.unavailable;
    }

    if (latency == null) {
      return NetworkQuality.unknown;
    }

    if (latency <= 50) {
      return NetworkQuality.excellent;
    }

    if (latency <= 100) {
      return NetworkQuality.good;
    }

    if (latency <= 200) {
      return NetworkQuality.fair;
    }

    return NetworkQuality.poor;
  }
}