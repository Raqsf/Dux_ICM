import 'dart:io';

import 'package:location/location.dart';
import 'package:dux/models/weather_models.dart';

import '../controllers/weather_api.dart';

class WeatherService {
  final WeatherApi weatherApi;
  WeatherService(this.weatherApi);

  Future<WeatherResponse> getWeather() async {
    final location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        exit(-1);
        // return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        exit(-1);
        // return;
      }
    }

    _locationData = await location.getLocation();

    return await weatherApi.getWeatherLocation(_locationData);
  }
}
