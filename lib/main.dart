import 'dart:async';

import 'package:flutter/material.dart';

import 'screens/welcome.dart';


void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
    )
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //GlobalBloc globalBloc;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Welcome()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}
