//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocation();
    super.initState();
  }
  void getLocation() async {
        Location location = Location();
        await location.getCurrentLocation();
        print(location.latitude);
        print(location.longitute);
  }

  void getData()async{
  //  http.Response response = await http.get(Uri.http('https://samples.openweathermap.org', '/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22'));

    final uri = Uri.parse('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    final response = await http.get(uri);
    if(response.statusCode == 200){

      var jsonResponse1 = jsonDecode(response.body) ['main']['temp'];
      var jsonResponse2 = jsonDecode(response.body) ['weather'][0]['description'];
      var jsonResponse3 = jsonDecode(response.body) ['name'];
      print(jsonResponse1);
      print(jsonResponse2);
      print(jsonResponse3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getData();
            //getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
