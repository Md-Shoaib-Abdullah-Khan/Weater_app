import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';

import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Free City, Night, Sky Background Images, Atmospheric City Background Photo Background PNG and Vectors.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Image(
                      height: 50.0,
                        width: 50.0,
                      image: AssetImage("images/left-arrow.png"),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        icon: Icon(
                          Icons.location_city,
                          color: Colors.orangeAccent.shade100,
                        ),
                        hintText: "Enter city name.",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                          cityName = value;
                        //print(cityName);
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, cityName);
                    },
                    child: Text(
                      'Get Weather',
                      style: TextStyle(
                        fontFamily: 'Lemon',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent.shade100,

                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
