import 'package:location/location.dart';
import 'package:dux/models/weather_models.dart';

abstract class WeatherApi {
  Future<WeatherResponse> getWeather();
  Future<WeatherResponse> getWeatherLocation(LocationData location);
}
