import 'dart:async';

import 'package:flutter/material.dart';

import 'screens/welcome.dart';

import 'package:medic_app_users/Models/global_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  GlobalBloc globalBloc;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Welcome()));
  }

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
    //startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        home: Scaffold(
          body: Welcome()
        ),
      ),
    );
  }
}
