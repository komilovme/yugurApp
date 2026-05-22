import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

bool isClosedPolygon(List<LatLng> points, {double thresholdMeters = 20}) {
  if (points.length < 10) return false;
  final d = const Distance().as(LengthUnit.Meter, points.first, points.last);
  return d <= thresholdMeters;
}

double polygonAreaApproxM2(List<LatLng> points) {
  if (points.length < 3) return 0;
  const r = 6378137.0;
  double area = 0;
  for (var i = 0; i < points.length; i++) {
    final p1 = points[i];
    final p2 = points[(i + 1) % points.length];
    area += (p2.longitude - p1.longitude) *
        (2 + math.sin(p1.latitude * math.pi / 180) + math.sin(p2.latitude * math.pi / 180));
  }
  return (area * r * r / 2).abs();
}
