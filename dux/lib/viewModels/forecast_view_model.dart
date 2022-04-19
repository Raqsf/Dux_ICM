import 'dart:core';

import 'package:dux/controllers/weather_controller.dart';
import 'package:dux/models/weather_models.dart';
import 'package:dux/services/weather_service.dart';
import 'package:flutter/cupertino.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  String? _cityName;
  int? _temperature;
  String? _description;
  String? _icon;

  String? get cityName => _cityName;
  int? get temperature => _temperature;
  String? get description => _description;
  String? get icon => _icon;
  String? get iconUrl {
    if (_icon != null) {
      return 'https://openweathermap.org/img/wn/$_icon@2x.png';
    }
    return null;
  }

  WeatherService weatherService = WeatherService(WeatherController());

  Future<WeatherResponse> getLatestWeather() async {
    setRequestPendingState(true);
    isRequestError = false;

    late WeatherResponse latest;
    try {
      // await Future.delayed(Duration(seconds: 1), () => {});

      latest = await weatherService
          .getWeather()
          .catchError((onError) => isRequestError = true);
    } catch (e) {
      isRequestError = true;
    }

    isWeatherLoaded = true;
    updateModel(latest);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(WeatherResponse weather) {
    if (isRequestError) return;

    _cityName = weather.cityName;
    _description = weather.weatherInfo.description;
    _temperature = weather.tempInfo.temperature;
    _icon = weather.weatherInfo.icon;
  }
}
