import 'dart:convert';
import 'package:coronavirus_rest_api_flutter_course/app/models/africa_data_2.dart';
import 'package:coronavirus_rest_api_flutter_course/app/models/country_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/models/country_population.dart';
import 'package:coronavirus_rest_api_flutter_course/app/models/world_population.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_keys.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';

class APIService {
  APIService(this.api);
  final API api;
  

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<CountryData> getCountryData(String country) async {
    final response = await http.get(api.countryEndpointUri(country));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final dataModel = (data as List).map((f) => CountryData.fromJson(f)).toList();

      return dataModel.last;
    }
    print(
        'Request ${api.countryEndpointUri(country)} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }


  Future<SecondAfricaModel> getAfricaData() async{
    final uri = api.africaEndpointUri();

    final response = await http.get(uri.toString(), headers: {
      "X-RapidAPI-Host": APIKeys.rapidApiHost,
      "X-RapidAPI-Key": APIKeys.rapidApiKey
    });

    if(response.statusCode == 200){

      SecondAfricaModel africaData = SecondAfricaModel.fromJson(response.body);

      return africaData;
    }
    print(
        'Request ${api.africaEndpointUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

     

    Future<WorldPopulation> getWorldPopulation() async {

    final uri = api.worldPopulationEndpointUri();

    final response = await http.get(uri.toString(), headers: {
      "x-rapidapi-host": "world-population.p.rapidapi.com",
      "x-rapidapi-key" : "3ad8f0bcc4mshc7f162aecdd632dp1a050ejsn3d6461734d53"
    });

    if(response.statusCode == 200){

      WorldPopulation population = WorldPopulation.fromJson(response.body);
      
      
      return population;

    }
    print(
        'Request ${api.worldPopulationEndpointUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }


  Future<CountryPopulation> getCountryPopulation(String country) async {

    final uri = api.countryPopulationEndpointUri(country);

    final response = await http.get(uri.toString(), headers: {
      "x-rapidapi-host": "world-population.p.rapidapi.com",
      "x-rapidapi-key" : "3ad8f0bcc4mshc7f162aecdd632dp1a050ejsn3d6461734d53"
    });

    if(response.statusCode == 200){

      CountryPopulation population = CountryPopulation.fromJson(response.body);
      
      
      return population;

    }
    print(
        'Request ${api.countryEndpointUri(country)} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<EndpointData> getEndpointData({
    @required String accessToken,
    @required Endpoint endpoint,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint];
        final int value = endpointData[responseJsonKey];
        final String dateString = endpointData['date'];
        final date = DateTime.tryParse(dateString);
        if (value != null) {
          return EndpointData(value: value, date: date);
        }
      }
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
}
