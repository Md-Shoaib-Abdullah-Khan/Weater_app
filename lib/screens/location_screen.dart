import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/main.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //late var temperature = 0.0;
  late int condition = 0;
  late String cityName = "abc";
  late int temp = 0;
  late AssetImage weatherIcon = AssetImage('images/lightning-bolt-.png');
  String weatherMessage = "";
  late String weatherStatus = "";
  late Color weatherColor = Colors.white;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        //weatherIcon = "Error";
        weatherMessage = "Unable to get weather message!";
        print("Null");
        return;
      }
       //int test =200;
      var temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
      condition = weatherData['weather'][0]['id'];
      weatherStatus = weatherData['weather'][0]['main'];
      if(temp<=0){
        condition=650;
        weatherStatus='Snow';
      }
      cityName = weatherData['name'];
      weatherStatus="Thunderstorm";
      weatherIcon = weatherModel.getWeatherIcon(25);
      weatherMessage = weatherModel.getMessage(25);
      weatherColor = weatherModel.getWeatherColor(25);
      print(cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: weatherColor,
      body: Container(
        //constraints: BoxConstraints.expand(),
        height: 1000,
        width: 400,
        child: SafeArea(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: TextButton(
                      onPressed: () async {
                        var weatherData =
                            await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Image(
                        image: AssetImage("images/placeholder.png"),
                        width: 70.0,
                        height: 70.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () async {
                        var cityName = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        //print(cityName);

                        if (cityName != null) {
                          var weatherData = await weatherModel
                              .getCityWeather(cityName);
                          updateUI(weatherData);
                          print(weatherData['name']);
                        }
                        else print('Invalid');
                      },
                      child: Image(
                        image: AssetImage("images/city.png"),
                        width: 80.0,
                        height: 80.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("images/pin.png"),
                    width: 30.0,
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: StrokeText(
                      text: cityName,
                      textStyle: TextStyle(
                          fontFamily: 'Titillum',
                          fontSize: 40,
                          color: Colors.white),
                      strokeColor: Colors.black,
                      strokeWidth: 5,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(width: 200, height: 200.0, image: weatherIcon),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StrokeText(
                      text: '$temp°',
                      textStyle: TextStyle(
                          fontFamily: 'Titillum',
                          fontSize: 100,
                          color: Colors.white),
                      strokeColor: Colors.black,
                      strokeWidth: 5,
                    ),
                    StrokeText(
                      text: weatherStatus,
                      textStyle: TextStyle(
                          fontFamily: 'Titillum',
                          fontSize: 30,
                          color: Colors.white),
                      strokeColor: Colors.black,
                      strokeWidth: 5,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: StrokeText(
                    text: '$weatherMessage in $cityName',
                    textStyle: TextStyle(
                        fontFamily: 'Kalam', fontSize: 30, color: Colors.white),
                    strokeColor: Colors.black,
                    strokeWidth: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
