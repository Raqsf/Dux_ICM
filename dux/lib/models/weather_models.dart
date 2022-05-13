/* 
{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky", <-
      "icon": "01d"               <-
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,               <-
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 10000,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",        <-
  "cod": 200
}                         

 */

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(this.cityName, this.tempInfo, this.weatherInfo);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    return WeatherResponse(cityName, tempInfo, weatherInfo);
  }
}

class TemperatureInfo {
  final int temperature;

  TemperatureInfo(this.temperature);

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'].round();
    return TemperatureInfo(temperature);
  }
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo(this.icon, this.description);

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(icon, description);
  }
}
