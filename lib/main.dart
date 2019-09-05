import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medic_app_users/screens/home_page.dart';

import 'screens/welcome.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/WelcomeScreen': (BuildContext context) => new Welcome(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseUser user;
  FirebaseAuth auth = FirebaseAuth.instance;


  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async{

    user = await auth.currentUser();

    if(user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(user)));
    }
    else {
      Navigator.of(context).pushReplacementNamed('/WelcomeScreen');
    }
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
            image: AssetImage("assets/images/logo.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: null ,
      ),
    );
  }
}
