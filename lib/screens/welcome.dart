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
                  "Welcome to Medic App !",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 2
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 20.0),
                ),

                Container(
                  child: RaisedButton(
                    child: Text(
                      "Get Started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30
                      ),
                    ),
                    color: Colors.amber,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    elevation: 10,

                    onPressed: () {

                    },
                  ),
                  width: 200,
                  height: 70,
                )
              ],
            )
          )
        ],
      )
    );
  }
}