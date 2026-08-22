import 'package:flutter/widgets.dart';
import '../../../core/utils/api_service.dart';

typedef DwellTimeType = String;

/// Tracks how long a user stays on a programme and POSTs to `/ads/dwell-time`
/// when they leave (mirrors React `useDwellTime` + `trackDwellTime`).
class DwellTimeTracker with WidgetsBindingObserver {
  DwellTimeTracker(this.itemId, {this.type = 'Programmes'});

  final String? itemId;
  final DwellTimeType type;

  static const int _minDwellMs = 2000;

  String? _startTimeIso;
  int _startMs = 0;
  bool _sent = false;
  bool _attached = false;

  void start() {
    if (itemId == null || itemId!.isEmpty) return;
    _startTimeIso = DateTime.now().toUtc().toIso8601String();
    _startMs = DateTime.now().millisecondsSinceEpoch;
    _sent = false;
    if (!_attached) {
      WidgetsBinding.instance.addObserver(this);
      _attached = true;
    }
  }

  void dispose() {
    _send();
    if (_attached) {
      WidgetsBinding.instance.removeObserver(this);
      _attached = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      _send();
    }
  }

  void _send() {
    if (_sent) return;
    if (_startTimeIso == null || itemId == null || itemId!.isEmpty) return;

    final elapsed = DateTime.now().millisecondsSinceEpoch - _startMs;
    if (elapsed < _minDwellMs) return;

    _sent = true;
    final endTime = DateTime.now().toUtc().toIso8601String();

    try {
      ApiService.post(
        '/ads/dwell-time',
        body: {
          'item': itemId,
          'type': type,
          'startTime': _startTimeIso,
          'endTime': endTime,
        },
      );
    } catch (_) {}
  }
}
