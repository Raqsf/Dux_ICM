import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:dux/models/weather_models.dart';

import 'dart:convert';

class WeatherService {
  static const endPointUrl = 'api.openweathermap.org';
  static const endPointPath = '/data/2.5/weather';
  static const apiKey = '2130c6d15d6babf9e0019e82a4b0c931';

  @override
  Future<WeatherResponse?> getWeather() async {
    // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    location.changeSettings(accuracy: LocationAccuracy.high);
    _locationData = await location.getLocation();

    final queryParameters = {
      'lat': _locationData.latitude.toString(),
      'lon': _locationData.longitude.toString(),
      'units': 'metric',
      'appid': apiKey
    };

    final uri = Uri.https(endPointUrl, endPointPath, queryParameters);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      //throw Exception('error retrieving weather: ${response.statusCode}');
      return null;
    }

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
