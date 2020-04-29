
import 'dart:math';

import 'package:coronavirus_rest_api_flutter_course/app/models/africa_data_2.dart';
import 'package:coronavirus_rest_api_flutter_course/app/models/country_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/models/country_population.dart';
import 'package:coronavirus_rest_api_flutter_course/app/models/world_population.dart';
import 'package:coronavirus_rest_api_flutter_course/app/repositories/data_repository.dart';
import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/endpoint_card.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/last_updated_status_text.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:io';
import '../services/api.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;
  CountryData _countryData;
  SecondAfricaModel _africaModel;
  WorldPopulation _worldPopulation;
  CountryPopulation _countryPopulation;

  bool _isFetchingCountryData, _isFetchingAfricaData, _isFetchingWorldData, _isFetchingCountryPopulation;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
     
    _updateData();

    _updateAfricaData();

    _getCountryPopulationData();

    _getWorldPopulationData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
          final endpointcountrydata = await dataRepository.getCountryData("nigeria");

          //String worldPopulation = await dataRepository.getWorldPopulation();

          //print(worldPopulation);
      final endpointsData = await dataRepository.getAllEndpointsData();
       

      setState(() {
        _isFetchingCountryData = true;
        _isFetchingAfricaData = true;
        _endpointsData = endpointsData;
        _countryData = endpointcountrydata;
       
      });
       //
      if(_countryData != null){
        setState(() {
          _isFetchingCountryData = false;
        });
      }

    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'OK',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Unknown Error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'OK',
      );
    }
  }


  Future<void> _updateAfricaData() async {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);

      final africaData = await dataRepository.getAfricaData();

      setState(() {
        _isFetchingAfricaData = true;
         _africaModel = africaData;
      });

      if(_africaModel != null){
        setState(() {
          _isFetchingAfricaData = false;
        });
      }
  }

    Future<void> _getWorldPopulationData() async {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);

      final data = await dataRepository.getWorldPopulation();

      print(data.body.worldPopulation);

      setState(() {
        _isFetchingWorldData = true;
         _worldPopulation = data;
      });

      if(_worldPopulation != null){
        setState(() {
          _isFetchingWorldData = false;
        });
      }
  }

      Future<void> _getCountryPopulationData() async {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);

      final data = await dataRepository.getCountryPopulation("Nigeria");

      print(data.body.population);

      setState(() {
        _isFetchingCountryPopulation = true;
         _countryPopulation = data;
      });

      if(_countryPopulation != null){
        setState(() {
          _isFetchingCountryData = false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    var number = _getRandomPoliceNum();
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
          FloatingActionButton(
            onPressed: () => UrlLauncher.launch('tel: 080097000010'),
            child: Icon(Icons.local_hospital),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => UrlLauncher.launch('tel: $number'),
            child: Icon(Icons.report),
          )
        ]),
        appBar: AppBar(
          title: Text('Coronavirus Tracker'),
          bottom: TabBar(
            labelColor: Colors.deepPurpleAccent[600],
            unselectedLabelColor: Colors.deepPurpleAccent[900],
            tabs: [
              Tab(icon: Icon(Icons.flag)),
              Tab(icon: Icon(Icons.public)),
              Tab(icon: Icon(Icons.language))
            ],
          ),
        ),
        body: TabBarView(
          children: [_countryTab(), _africaTab(), _worldTab()],
        ),
      ),
    );
  }

  String _lastUpdated(String tab) {
    final getter = LastUpdatedDateFormatter(
      lastUpdated: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases]?.date
          : null,
    );

    return getter.lastUpdatedStatusText(tab);
  }

  _worldTab() {
    return ListView(
      children: <Widget>[
        LastUpdatedStatusText(
          text: _lastUpdated("Worldwide"),
        ),
        for (var endpoint in Endpoint.values)
          EndpointCard(
            endpoint: endpoint,
            value: _addPopulationValue(endpoint),
          ),
      ],
    );
  }

  int _addPopulationValue(Endpoint endpoint){
    if(_endpointsData == null){
      return 0;
    }

    if(_worldPopulation == null){
      return 0;
    }

    if(endpoint == Endpoint.casesSuspected){
      return _worldPopulation.body.worldPopulation;
    }else if(endpoint == Endpoint.cases){
      // cases =  _countryData.confirmed - _countryData.deaths - _countryData.recovered;
      return _endpointsData.values[Endpoint.casesConfirmed]?.value - _endpointsData.values[Endpoint.deaths]?.value - _endpointsData.values[Endpoint.recovered]?.value;
    }


    else{
      return _endpointsData.values[endpoint]?.value;
    }
  }

 String _getRandomPoliceNum(){
   var rnd = new Random();
    var list = ['08033893226', '08127155132', '08065154338', '07055462708', '08065668179', '08073666669', '08033172889'];

    var element = list[rnd.nextInt(list.length)];

    print(element);
   
    return element;
  }

 


  _africaTab() {
    return ListView(
      children: <Widget>[
       // _isFetchingAfricaData == true ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)):
        LastUpdatedStatusText(
          text: _lastUpdated("Africa"),
        ),
        for (var endpoint in Endpoint.values)
          EndpointCard(
            endpoint: endpoint,
            value: _getAfricaData(endpoint),
          ),
      ],
    );
  }

  int _getCountryEndpoint(Endpoint endpoint){
    if(_countryData == null){
      return 0;
    }
    int cases =  _countryData.confirmed - _countryData.deaths - _countryData.recovered;
    if(endpoint == Endpoint.cases){
      return cases;
    }else if(endpoint == Endpoint.casesConfirmed){
      return cases + _countryData.deaths + _countryData.recovered;
    }else if(endpoint == Endpoint.casesSuspected){
      return _countryPopulation.body.population;
    }else if(endpoint == Endpoint.deaths){
      return _countryData.deaths;
    }else if(endpoint == Endpoint.recovered){
      return _countryData.recovered;
    }else{
      return null;
    }
  }

  int _convertedNum(dynamic number){
    int intNumber = int.parse(number.toString());

    return intNumber;
  }

  int _getAfricaData(Endpoint endpoint){

    //AfricaData africaModel;
      int active = 0;
      int confirmed = 0;
      int deaths = 0;
      int recovered = 0;
      int popEst = 0;

      if(_africaModel != null){
          _africaModel.features.forEach((info){
        
        _convertedNum(info.properties.active);
        active += _convertedNum(info.properties.active);
        confirmed += _convertedNum(info.properties.confirmed);
        deaths += _convertedNum(info.properties.deaths);
        recovered += _convertedNum(info.properties.recovered);
        popEst += _convertedNum(info.properties.popEst);
        
      });
      }
       

      if(endpoint == Endpoint.cases){
      return active;
    }else if(endpoint == Endpoint.casesConfirmed){
      return confirmed;
    }else if(endpoint == Endpoint.casesSuspected){
      return popEst;
    }else if(endpoint == Endpoint.deaths){
      return deaths;
    }else if(endpoint == Endpoint.recovered){
      return recovered;
    }else{
      return null;
    }
      // africaModel.properties.active = active;
      // africaModel.properties.confirmed = confirmed;
      // africaModel.properties.deaths = deaths;
      // africaModel.properties.recovered = recovered;
      // africaModel.properties.popEst = popEst;

      //return africaModel;

  }

  _countryTab() {
    //return Text("Test");
    return ListView(
      children: <Widget>[
       // _isFetchingCountryData == true ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)):
        LastUpdatedStatusText(
          text: _lastUpdated("Nigeria"),
        ),
        for (var endpoint in Endpoint.values)
          EndpointCard(
            endpoint: endpoint,
            value: _getCountryEndpoint(endpoint),
          ),
      ],
    );
  }
}
