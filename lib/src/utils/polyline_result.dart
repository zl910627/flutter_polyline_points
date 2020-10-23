import 'dart:convert';

import 'package:http/http.dart';

import '../../flutter_polyline_points.dart';
import '../PointLatLng.dart';

/// description:
/// project: flutter_polyline_points
/// @package:
/// @author: dammyololade
/// created on: 13/05/2020
class PolylineResult {
  /// the api status retuned from google api
  ///
  /// returns OK if the api call is successful
  String status;

  /// list of decoded points
  List<PointLatLng> points;

  /// Bounds
  Bound bounds;

  /// Distance In Meter
  double distance;

  /// Duration in seconds
  double duration;

  /// the error message returned from google, if none, the result will be empty
  String errorMessage;

  PolylineResult({this.status, this.points = const [], this.errorMessage = ""});

  static PolylineResult parseResposne(Response response) {
    final result = PolylineResult();

    if (response?.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);

      result.status = parsedJson["status"];
      if (parsedJson["status"]?.toLowerCase() == NetworkUtil.STATUS_OK &&
          parsedJson["routes"]?.isNotEmpty == true) {
        final route = parsedJson["routes"][0];
        result.points = NetworkUtil.decodeEncodedPolyline(
          route["overview_polyline"]["points"],
        );

        final bound = route['bounds'];
        if (bound != null) {
          result.bounds = Bound(
            PointLatLng(
              bound['northeast']['lat'],
              bound['northeast']['lng'],
            ),
            PointLatLng(
              bound['southwest']['lat'],
              bound['southwest']['lng'],
            ),
          );
        }

        final leg = route['legs'][0];
        result.distance = leg['distance']['value'];
        result.duration = leg['duration']['value'];
      } else {
        result.errorMessage = parsedJson["error_message"];
      }
    }
    return result;
  }
}
