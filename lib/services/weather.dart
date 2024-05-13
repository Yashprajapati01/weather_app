import 'package:flutter/cupertino.dart';
import 'package:myweather/services/networking.dart';
import 'package:myweather/screens/loading_screen.dart';
import 'package:myweather/services/location.dart';

import 'location.dart';
const apikey = '9ed514649eb94e4da9ee92ee30cf612c';
class WeatherModel {

  Future <dynamic> cityWeather(String cityName) async{
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  Image getWeatherIcon(int condition) {
    if (condition >= 200 && condition < 300) {
      return Image.asset('assests/1.png');
    } else if (condition >= 300 && condition < 400) {
      return Image.asset('assests/2.png');
    } else if (condition >= 500 && condition < 600) {
      return Image.asset('assests/3.png');
    } else if (condition >= 600 && condition < 700) {
      return Image.asset('assests/4.png');
    } else if (condition >= 700 && condition < 800) {
      return Image.asset('assests/5.png');
    } else if (condition == 800) {
      return Image.asset('assests/6.png');
    } else if (condition >= 800 && condition <= 804) {
      return Image.asset('assests/7.png');
    } else {
      return Image.asset('assests/7.png');
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s  raining 🔥 in the sky.';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
