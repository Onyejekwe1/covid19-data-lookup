import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoint, EndpointData> values;
  // cases =  _countryData.confirmed - _countryData.deaths - _countryData.recovered;
  EndpointData get casesSuspected => values[Endpoint.casesSuspected];
  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get recovered => values[Endpoint.recovered];
  EndpointData get cases => values[Endpoint.casesConfirmed];

  @override
  String toString() =>
      'suspected: $casesSuspected, cases: $cases, confirmed: $casesConfirmed, recovered: $recovered, deaths: $deaths';
}
