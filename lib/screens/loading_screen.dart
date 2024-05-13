import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myweather/screens/location_screen.dart';
import 'package:myweather/services/location.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myweather/services/weather.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherdata = await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherdata);
    },
    ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.discreteCircle(color: Colors.white, size: 45.0),
        // child: LoadingAnimationWidget.inkDrop(color: Colors.white, size: 45.0),
      ),
    );
  }
}
