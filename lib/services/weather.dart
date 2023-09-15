import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const apiKey = 'b0faa038e4d597112da4182065339588';

class WeatherModel {
  late double latitude;
  late double longitude;

  Future<dynamic> getCityWeather(String cityName) async{
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather () async {
  Location location = Location();
  await location.getCurrentLocation();
  latitude = location.latitude;
  longitude = location.longitute;

  NetworkHelper networkHelper = NetworkHelper(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));
  var weatherData = await networkHelper.getData();
  return weatherData;
}
  AssetImage getWeatherIcon(int condition) {
    if (condition < 300) {
      return AssetImage('images/lightning-bolt-.png');
    } else if (condition < 400) {
      return AssetImage('images/cloudy.png');;
    } else if (condition < 600) {
      return AssetImage('images/raining.png');;
    } else if (condition < 700) {
      return AssetImage('images/snow.png');;
    } else if (condition < 800) {
      return AssetImage('images/mist.png');;
    } else if (condition == 800) {
      return AssetImage('images/sun.png');;
    } else if (condition <= 804) {
      return AssetImage('images/overcast.png');;
    } else {
      return AssetImage('images/lightning-bolt-.png');;
    }
  }
  Color getWeatherColor(int condition) {
    if (condition < 300) {
      return Colors.purple.shade900;
    } else if (condition < 400) {
      return Colors.blue;
    } else if (condition < 600) {
      return const  Color.fromARGB(255,60,127,222);
    } else if (condition < 700) {
      return const  Color.fromARGB(255,95,196,251);
    } else if (condition < 800) {
      return Colors.grey;
    } else if (condition == 800) {
      return Colors.lightBlueAccent;
    } else if (condition <= 804) {
      return Colors.blueGrey.shade600;
    } else {
      return Colors.orangeAccent;
    }
  }


  String getMessage(int condition) {
    if (condition < 300) {
      return 'Bring a 🧥 just in case';
    } else if (condition < 400) {
      return "It's time for ⚽";
    } else if (condition < 600) {
      return 'Best time for reading novels';
    } else if (condition < 700) {
      return 'Time for making ☃️';
    } else if (condition < 800) {
      return "Enjoy the weather with a cup of coffee";
    } else if (condition == 800) {
      return 'It\'s 🍦 time';
    } else if (condition <= 804) {
      return "Such a romantic weather";
    } else {
      return 'sleep';
    }
  }
}
