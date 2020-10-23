import 'dart:math' show cos, sqrt, asin;

/// A pair of latitude and longitude coordinates, stored as degrees.
class PointLatLng {
  /// Creates a geographical location specified in degrees [latitude] and
  /// [longitude].
  ///
  const PointLatLng(double latitude, double longitude)
      : assert(latitude != null),
        assert(longitude != null),
        this.latitude = latitude,
        this.longitude = longitude;

  /// The latitude in degrees.
  final double latitude;

  /// The longitude in degrees
  final double longitude;

  @override
  String toString() {
    return "lat: $latitude / longitude: $longitude";
  }

  double distance(PointLatLng other) {
    const p = 0.017453292519943295;
    final a = 0.5 - cos((other.latitude - latitude) * p) / 2 +
        cos(latitude * p) * cos(other.latitude * p) *
        (1 - cos((other.longitude - longitude) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

class Bound {
  Bound(this.northeast, this.southwest);

  final PointLatLng northeast;

  final PointLatLng southwest;

  PointLatLng get midPoint => PointLatLng(
        (northeast.latitude + southwest.latitude) / 2,
        (northeast.longitude + southwest.longitude) / 2,
      );

  @override
  String toString() {
    return "northeast: $northeast / southwest: $southwest";
  }
}
