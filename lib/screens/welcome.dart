import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home_page.dart';
import 'package:flutter/cupertino.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  String buttonText = "Get Started";
  String _email,_password;
  Widget Home;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  _WelcomeState() {
    Home = welcomePage();
  }
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

          Home,

        ],
      )
    );
  }

  Widget welcomePage() {
    return Center(
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
              padding: EdgeInsets.only(top: 30.0),
            ),

            Container(
              child: RaisedButton(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      letterSpacing: 2
                  ),
                ),
                color: Colors.amber,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 10,

                onPressed: () {
                  setState(() {
                    buttonText = "Log In";
                    Home = signPage();
                  });
                },
              ),
              width: 250,
              height: 70,
            )
          ],
        )
    );
  }

  Widget signPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _form,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: TextFormField(
                    validator: (input) {
                      if(input.isEmpty)
                        return "Please enter the Email";
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 20),
                ),

                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: TextFormField(
                    validator: (input) {
                      if(input.length < 6)
                        return "Please enter a password greater than 6 characters";
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                        hintText: "Enter Your Patient ID",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        labelText: "Patient ID",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    obscureText: true,
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 20),
                ),

                Container(
                  child: RaisedButton(
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          letterSpacing: 2
                      ),
                    ),
                    color: Colors.amberAccent[200],
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 10,

                    onPressed: () {
                      signinUser();
                    },
                  ),
                  width: 250,
                  height: 70,
                )

              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> signinUser() async{
    final formState = _form.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(user);
        }));
      } catch(e) {
        print(e);
      }
    }
  }
}