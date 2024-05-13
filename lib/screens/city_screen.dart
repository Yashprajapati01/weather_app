import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myweather/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark
        ),
      ),
      body:  Padding(padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
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
              SafeArea(child: Column(
                  children: <Widget>[
                Container(
                              padding: EdgeInsets.all(20.0),
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: kfieldInput,
                                onChanged: (value) {
                                  cityName = value;
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, cityName);
                              },
                              child: const Text(
                                'Get Weather',
                                style: kButtonTextStyle,
                              ),
                            ),
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage('images/city_background.jpg'),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     constraints: BoxConstraints.expand(),
    //     child: SafeArea(
    //       child: Column(
    //         children: <Widget>[
    //           Align(
    //             alignment: Alignment.topLeft,
    //             child: TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Icon(
    //                 Icons.arrow_back_ios,
    //                 size: 50.0,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.all(20.0),
    //             child: TextField(
    //               style: TextStyle(
    //                 color: Colors.black,
    //               ),
    //               decoration: kfieldInput,
    //               onChanged: (value) {
    //                 cityName = value;
    //               },
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context, cityName);
    //             },
    //             child: const Text(
    //               'Get Weather',
    //               style: kButtonTextStyle,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
