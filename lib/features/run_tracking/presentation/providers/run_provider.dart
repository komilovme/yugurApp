import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/services/location_service.dart';

final runProvider = StateNotifierProvider<RunNotifier, RunState>((ref) {
  return RunNotifier(LocationService());
});

class RunState {
  final bool running;
  final List<Position> points;

  const RunState({this.running = false, this.points = const []});

  RunState copyWith({bool? running, List<Position>? points}) {
    return RunState(running: running ?? this.running, points: points ?? this.points);
  }
}

class RunNotifier extends StateNotifier<RunState> {
  RunNotifier(this._location) : super(const RunState());

  final LocationService _location;
  StreamSubscription<Position>? _sub;

  Future<void> start() async {
    await _location.ensurePermission();
    state = state.copyWith(running: true, points: []);
    _sub = _location.stream().listen((p) {
      state = state.copyWith(points: [...state.points, p]);
    });
  }

  Future<void> stop() async {
    await _sub?.cancel();
    state = state.copyWith(running: false);
  }
}
