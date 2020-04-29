import 'package:coronavirus_rest_api_flutter_course/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint {
  casesSuspected,
  casesConfirmed,
  cases,
  recovered,
  deaths,
}

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = 'apigw.nubentos.com';
  
  static final int port = 443;
  static final String basePath = 't/nubentos.com/ncovapi/1.0.0';

  static final String countryHost = 'api.covid19api.com';
  static final String countryBasePath = '/country';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: '$basePath/${_paths[endpoint]}',
      );

  Uri countryEndpointUri(String country) => Uri(
      scheme: 'https',
      host: countryHost,
      path: '$countryBasePath/$country'
  );

  Uri worldPopulationEndpointUri() => Uri(
    scheme: 'https',
    host: 'world-population.p.rapidapi.com',
    path: '/worldpopulation'
  );

  var queryParameters = {
  'country_name': 'Nigeria'
};

  Uri countryPopulationEndpointUri(String country) => Uri(
    scheme: 'https',
    host: 'world-population.p.rapidapi.com',
    path: '/population',
    queryParameters: queryParameters
  );

  Uri africaEndpointUri() => Uri(
    scheme: 'https',
    host: 'covid19-data.p.rapidapi.com',
    path: '/geojson-af'
  );

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'cases/suspected',
    Endpoint.casesConfirmed: 'cases/confirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };
}
