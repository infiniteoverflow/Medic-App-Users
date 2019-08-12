import 'package:flutter/material.dart';
import 'package:medic_app_users/Models/styles.dart';
import 'package:medic_app_users/Models/login_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';

import 'package:medic_app_users/Components/SignUpLink.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medic_app_users/Components/WhiteTick.dart';

import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {

  FirebaseUser user;

  TextEditingController email = TextEditingController();
  TextEditingController patID = TextEditingController();

  DecorationImage backgroundImage = new DecorationImage(
    image: new ExactAssetImage('assets/images/login.jpg'),
    fit: BoxFit.cover,
  );

  DecorationImage tick = new DecorationImage(
    image: new ExactAssetImage('assets/images/tick.png'),
    fit: BoxFit.cover,
  );

  AnimationController _loginButtonController;
  var animationStatus = 0;
  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Are you sure?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, "/home"),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                image: backgroundImage,
              ),
              child: new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: <Color>[
                          const Color.fromRGBO(162, 146, 199, 0.8),
                          const Color.fromRGBO(51, 51, 63, 0.9),
                        ],
                        stops: [0.2, 1.0],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                      )),
                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Tick(image: tick),
                              Container(
                                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Form(
                                        child: new Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            new InputFieldArea(
                                              controller: email,
                                              hint: "Username",
                                              obscure: false,
                                              icon: Icons.person_outline,
                                            ),
                                            new InputFieldArea(
                                              controller: patID,
                                              hint: "Password",
                                              obscure: true,
                                              icon: Icons.lock_outline,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              FlatButton(
                                padding: const EdgeInsets.only(
                                  top: 160.0,
                                ),
                                onPressed: null,
                                child: new Text(
                                  "Don't have an account? Sign Up",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                      fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                          animationStatus == 0
                              ? new Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: new InkWell(
                                onTap: () {
                                  setState(() {
                                    animationStatus = 1;
                                  });
                                  _playAnimation();
                                },
                                child: GestureDetector(
                                  child: Container(
                                    width: 320.0,
                                    height: 60.0,
                                    alignment: FractionalOffset.center,
                                    decoration: new BoxDecoration(
                                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                                      borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
                                    ),
                                    child: Text(
                                      "Sign In",
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    circularLoader();
                                    signIn();
                                  },
                                )),
                          )
                              : new StaggerAnimation(
                            email: email.text,
                              patId: patID.text,
                              buttonController:
                              _loginButtonController.view),
                        ],
                      ),
                    ],
                  ))),
        )));
  }

  Widget circularLoader() {
    return CircularProgressIndicator(

    );
  }

  Future<void> signIn() async{
    try {
      user = await FirebaseAuth.instance.
      signInWithEmailAndPassword(
          email: email.text,
          password: patID.text
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(user);
      }));
    } catch(e) {
      print(e);
    }
  }
}

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  TextEditingController controller = TextEditingController();

  InputFieldArea({this.hint, this.obscure, this.icon,this.controller});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
        ),
      ),
      child: new TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
        ),
      ),
    ));
  }
}
