
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {

  Widget Home;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext con;

  String _email,_id;

  FirebaseAuth auth = FirebaseAuth.instance;


  _WelcomeState() {
    getUser();
  }

  @override
  void initState() {

    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[

            Center(
                child: loginScreen()
            )
          ],
        )
    );
  }

  Widget welcomeScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Image(
          image: AssetImage('assets/images/logo2.png'),
        ),


        Container(
          padding: EdgeInsets.only(top: 30.0),
        ),

        Container(
          child: RaisedButton(
            child: Text(
              "Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  letterSpacing: 2
              ),
            ),
            color: Colors.green,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            elevation: 10,

            onPressed: () {
              setState(() {
                this.Home = loginScreen();
                con = context;
              });
            },
          ),
          width: 250,
          height: 70,
        )
      ],
    );
  }

  Widget loginScreen() {
    return ListView(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              Image(
                image: AssetImage('assets/images/logo2.png'),
              ),

              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  validator: (input) {
                    if(input.isEmpty)
                      return "Please enter an Email";
                    else return null;
                  },
                  onSaved: (input) {
                    _email = input;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter the Email Address",
                      labelText: "Email Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10,right: 20,left: 20),
                child: TextFormField(
                  validator: (input) {
                    if(input.isEmpty)
                      return "Please Enter the ID";
                    else return null;
                  },
                  onSaved: (input) {
                    _id = input;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter the Doctor ID",
                      labelText: "Doctor ID",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                  obscureText: true,
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 40,right: 20,left: 20),
                width: 300,
                height: 80,
                child: RaisedButton(
                  child: Text(
                      "LogIn"
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    loginUser();
                  },
                  elevation: 10,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
              )

            ],
          ),
        )
      ],
    );
  }

  Future<void> getUser() async{
    FirebaseUser user =await auth.currentUser();

    if(user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user)));
    }

  }

  Future<void> loginUser() async{
    final formState = _formKey.currentState;

    if(formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(user);
        }));
      }catch(e) {
        print("Hello ${e.toString()}");

        SystemChannels.textInput.invokeMethod('TextInput.hide');

        switch(e.toString()) {
          case 'PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)':
            normalSnackBar(con, "Enter a Valid Email ID");
            break;
          case 'PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)':
            normalSnackBar(con, "Doctor ID Incorrect");
            break;
          case 'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)':
            normalSnackBar(con, "User does not exist");
            break;
          case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':
            normalSnackBar(con, "Check Your Internet Connection");
            break;
          default:
            normalSnackBar(con,"Please check the Credentials");
        }
      }
    }
  }

  void normalSnackBar(BuildContext context,String error) {
    var snackBar = SnackBar(
      content: Text(
          error
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}