

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
  final int latitude;

  /// The longitude in degrees
  final int longitude;

  @override
  String toString() {
    return "lat: $latitude / longitude: $longitude";
  }
}

class Bound {
 Bound(this.northeast, this.southwest);

  final PointLatLng northeast;

  final PointLatLng southwest;

  @override
  String toString() {
    return "northeast: $northeast / southwest: $southwest";
  }
}