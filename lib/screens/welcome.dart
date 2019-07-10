import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: null /* add child content here */,
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome to Medic App !"
                ),

                Container(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                RaisedButton(
                  child: Text(
                      "Hello World"
                  ),
                  onPressed: () {

                  },
                ),
              ],
            )
          )
        ],
      )
    );
  }
}