import 'dart:async';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:myweather/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:myweather/utilities/constants.dart';
import 'package:myweather/screens/city_screen.dart';

import '../services/time.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.loactionWeather);
  final loactionWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int tempp = 0;
  int mintemp = 0;
  int maxtemp = 0;
  var tit ;
  Image icon_image = Image.asset('assests/13.png');
  String city = '';
  String msg = '';
  String SunsetTime = '';
  String SunriseTime = '';

  WeatherModel weather = WeatherModel();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.loactionWeather);
  }
  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData == null){
        tempp = 0;
        maxtemp = 0;
        mintemp = 0;
        icon_image == null;
        msg = 'Unable to find weather data';
        city = '';
        SunriseTime = '';
        SunsetTime = '';
        return;
      }
    double temp = weatherData['main']['temp'];
    tempp = temp.toInt();
    double mintempp = weatherData['main']['temp_min'];
    mintemp = mintempp.toInt();
    double maxtempp = weatherData['main']['temp_max'];
    maxtemp = maxtempp.toInt();
    var cond = weatherData['weather'][0]['id'];
    cond = cond.toInt();
    icon_image = weather.getWeatherIcon(cond);
    msg = weather.getMessage(tempp);
    tit = weatherData['weather'][0]['main'];
    city = weatherData['name'];
    int sunrise = weatherData['sys']['sunrise'];
    int sunset = weatherData['sys']['sunset'];
      DateTime sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
      SunriseTime = DateFormat('h:mm a').format(sunriseDateTime);
      DateTime sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
      SunsetTime = DateFormat('h:mm a').format(sunsetDateTime);
    });
  }
  Future<void> _refreshData() async{
    print('Refreshing data...');
    var weatherData = await weather.getLocationWeather();
    print('Weather data refreshed: $weatherData');
    DateTime currentTime = DateTime.now();
    print('Current time refreshed: $currentTime');
    setState(() {
      updateUI(weatherData);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark
        ),
      ),
      body:  RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 225,
                    width: 225,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 225,
                    width: 225,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 260,
                    width: 520,
                    decoration: BoxDecoration(
                      color: Color(0xffffab40),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: () async {
                              var WeatherData = await weather.getLocationWeather();
                              updateUI(WeatherData);
                              }, child: Text(
                            '$city',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                            //   '$city',
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.w300
                            //   ),
                            // ),
                          ),
                          TextButton(
                            onPressed: () async{
                              var Typedname = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CityScreen(),
                                ),
                              );
                              if(Typedname != null){
                                var WeatherData = await weather.cityWeather(Typedname);
                                updateUI(WeatherData);
                              }
                              },
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Text(
                        getgreeting(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      icon_image,
                      Center(
                        child: Text(
                          '$tempp°C',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '$tit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Center(
                        child: Text(
                          '${getCurrentWeekday()} ${getCurrentDate()} ‧ ${getCurrentTime()} ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assests/11.png',
                                scale: 8,
                              ),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sunrise',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Text(
                                    '$SunriseTime',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assests/12.png',
                                scale: 8,
                              ),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sunset',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Text(
                                    '$SunsetTime',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Padding(padding: EdgeInsets.symmetric(vertical: 5.0),
                      //   child: Divider(
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assests/13.png',
                                scale: 8,
                              ),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Temp Max',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Text(
                                    '$maxtemp°C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assests/14.png',
                                scale: 8,
                              ),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Temp Min',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Text(
                                    '$mintemp°C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage('images/location_background.jpg'),
    //         fit: BoxFit.cover,
    //         colorFilter: ColorFilter.mode(
    //             Colors.white.withOpacity(0.8), BlendMode.dstATop),
    //       ),
    //     ),
    //     constraints: BoxConstraints.expand(),
    //     child: SafeArea(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               TextButton(
    //                 onPressed: () async {
    //                   var WeatherData = await weather.getLocationWeather();
    //                   updateUI(WeatherData);
    //                 },
    //                 child: Icon(
    //                   Icons.near_me,
    //                   size: 50.0,
    //                 ),
    //               ),
    //               TextButton(
    //                 onPressed: () async{
    //                   var Typedname = await Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => CityScreen(),
    //                     ),
    //                   );
    //                   if(Typedname != null){
    //                     var WeatherData = await weather.cityWeather(Typedname);
    //                     updateUI(WeatherData);
    //                   }
    //                 },
    //                 child: Icon(
    //                   Icons.location_city,
    //                   size: 50.0,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(left: 15.0),
    //             child: Row(
    //               children: <Widget>[
    //                 Text(
    //                   '$tempp°',
    //                   style: kTempTextStyle,
    //                 ),
    //                 Text(
    //                   icon,
    //                   style: kConditionTextStyle,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(right: 15.0),
    //             child: Text(
    //               "$msg in $city!",
    //               textAlign: TextAlign.right,
    //               style: kMessageTextStyle,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
