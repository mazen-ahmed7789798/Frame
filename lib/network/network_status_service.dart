import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// جودة الاتصال بالإنترنت.
enum NetworkQuality {
  excellent,
  good,
  fair,
  poor,
  unavailable,
  unknown,
}

/// تقرير كامل عن حالة الشبكة.
class NetworkReport {
  /// أنواع الاتصال الموجودة على الجهاز.
  final List<ConnectivityResult> connectionTypes;

  /// هل توجد واجهة شبكة؟
  final bool hasNetwork;

  /// هل الإنترنت متاح فعليًا؟
  final bool hasInternet;

  /// زمن الاستجابة بالـ milliseconds.
  ///
  /// null إذا لم نستطع قياسه.
  final int? latency;

  /// جودة الاتصال.
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

/// Service واحدة مسؤولة عن فحص حالة الشبكة.
///
/// تشمل:
/// - نوع الاتصال.
/// - وجود Network Interface.
/// - وجود Internet فعلي.
/// - قياس Latency.
/// - تقييم جودة الاتصال.
class NetworkService {
  final Connectivity _connectivity;
  final InternetConnection _internetConnection;

  NetworkService({
    Connectivity? connectivity,
    InternetConnection? internetConnection,
  })  : _connectivity = connectivity ?? Connectivity(),
        _internetConnection =
            internetConnection ?? InternetConnection();

  /// الحصول على تقرير الشبكة الحالي.
  Future<NetworkReport> check() async {
    final connectionTypes =
        await _connectivity.checkConnectivity();

    final hasNetwork = connectionTypes.isNotEmpty &&
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

  /// مراقبة تغير حالة الاتصال.
  Stream<NetworkReport> get onNetworkChanged async* {
    await for (final _ in _connectivity.onConnectivityChanged) {
      yield await check();
    }
  }

  /// قياس زمن الاستجابة.
  ///
  /// يتم إرسال عدة طلبات واستخدام متوسط النتائج
  /// للحصول على قيمة أكثر استقرارًا.
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
      } catch (_) {
        // نتجاهل المحاولة الفاشلة.
      }
    }

    if (values.isEmpty) {
      return null;
    }

    final average =
        values.reduce((a, b) => a + b) / values.length;

    return average.round();
  }

  /// تحديد جودة الشبكة بناءً على حالة الإنترنت والـ latency.
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
