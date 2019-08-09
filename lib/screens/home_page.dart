import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medic_app_users/Models/medicines.dart';
import 'visit_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:medic_app_users/Models/mediminders.dart';
import 'package:medic_app_users/screens/medicine_details.dart';
import 'package:medic_app_users/screens/new_entry.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:firebase_database/ui/firebase_animated_list.dart';


class HomePage extends StatefulWidget {

  FirebaseUser user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference reference;


  String name = " ",address = " ",dob = " ",id = " ",age = " ";

  Widget Home,D;

  int bottomBarIndex = 0;
  String title = "Mediminders";

  //  String name;

  void initState() {
    super.initState();
    reference = database.reference().child("Patients").child(widget.user.uid);

    starter();

    Home = mediminder();
  }

  Future<void> starter() async{
    await reference.once().then((DataSnapshot snapshot) {
      this.name = snapshot.value['firstname'] + " " + snapshot.value['lastname'];
      this.address = snapshot.value['address'];
      this.dob = snapshot.value['dob'];
      this.id = snapshot.value['patientid'];
      this.age = snapshot.value['age'];

      print(this.id);

      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NewEntry(widget.user)));
            },
          )
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            UserAccountsDrawerHeader (
              accountName: Text(this.name[0].toUpperCase()+ this.name.substring(1)),
              accountEmail: Text(widget.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: Text(
                  this.name.substring(0,1).toUpperCase(),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(CupertinoIcons.person_add_solid),
                title: Text(
                    "Patient Details"
                ),
                trailing: Icon(Icons.arrow_forward ,color: Colors.black,),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoPopupSurface(
                          child: ListView(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                      height: 50,
                                      child: RaisedButton(
                                        child: Icon(CupertinoIcons.back),
                                        color: Colors.amber,
                                        onPressed: () {
                                          Navigator.of(context, rootNavigator: true).pop();
                                        },
                                        shape: CircleBorder(
                                          side: BorderSide(
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.all(30),
                              ),

                              Card(
                                child: ListTile(
                                    title: Text(
                                      widget.user.email,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    leading: SizedBox(
                                        child: Icon(Icons.email,color: Colors.red,)
                                    )
                                ),
                              ),

                              Card(
                                child: ListTile(
                                    title: Text(
                                      this.name.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    leading: SizedBox(
                                        child: Icon(Icons.person,color: Colors.red,)
                                    )
                                ),
                              ),

                              Card(
                                child: ListTile(
                                    title: Text(
                                      this.id,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    leading: SizedBox(
                                        child: Icon(CupertinoIcons.tags_solid,color: Colors.red,)
                                    )
                                ),
                              ),


                              Card(
                                child: ListTile(
                                    title: Text(
                                      this.age,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    leading: SizedBox(
                                        child: Text(
                                          "Age :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                            fontSize: 22
                                          ),
                                        )
                                    )
                                ),
                              ),


                              Card(
                                child: ListTile(
                                    title: Text(
                                      this.address,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    leading: SizedBox(
                                        child: Text(
                                          "Address :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigoAccent,
                                              fontSize: 22
                                          ),
                                        )
                                    )
                                ),
                              ),


                              Card(
                                child: ListTile(
                                    title: Text(
                                      this.dob,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    leading: SizedBox(
                                        child: Text(
                                          "Date of Birth :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 22
                                          ),
                                        )
                                    )
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(30),
                              ),

                              Center(
                                child: SizedBox(
                                  height: 50,
                                  child: RaisedButton(
                                    child: Text(
                                      "Update Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                    onPressed: () {

                                    },
                                    color: Colors.amber,
                                  ),
                                )
                              )

                            ],
                          )
                      )
                  );
                },
              ),
            )
          ],
        ),
      ),

      body: Home,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomBarIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarms),
            title: Text(
              "Mediminders"
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            title: Text(
              "Visit Details"
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text(
              "Notifications"
            )
          )
        ],
        onTap: (int index) {
          setState(() {
            bottomBarIndex = index;

            switch(index) {
              case 0: Home = mediminder();
                      title = "Mediminders";
                      break;

              case 1: Home = VisitDetails(widget.user);
                      title = "Visit Details";
                      break;

              case 2: Home = notifications();
                      title = "Notifications";
                      break;
            }
          });
        },
      ),
    );
  }

  Widget selectIcon(Map<dynamic , dynamic> map) {
    if(map['type'] == "Tablet") {
      return Icon(
        IconData(0xe903, fontFamily: "Ic"),
        size: 75,
        color: Color(0xFF3EB16F),
      );
    }

    else if(map['type'] == "Bottle") {
      return Icon(
        IconData(0xe900, fontFamily: "Ic"),
        size: 75,
        color: Color(0xFF3EB16F),
      );
    }

    else if(map['type'] == "Pill") {
      return Icon(
        IconData(0xe901, fontFamily: "Ic"),
        size: 75,
        color: Color(0xFF3EB16F),
      );
    }

    return Icon(
      IconData(0xe902, fontFamily: "Ic"),
      size: 75,
      color: Color(0xFF3EB16F),
    );
  }

  Widget mediminder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Flexible(
          child: StreamBuilder(
              stream: reference.child("Mediminders").onValue,
              builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  map.forEach((dynamic, v) => print(v["pic"]));

                  print(map.values.elementAt(0));


                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: map.values.toList().length,
                      padding: EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListView(
                            children: <Widget>[

                              selectIcon(map.values.elementAt(index)),

                              Center(
                                child: Text(
                                  map.values.elementAt(index)['mediname'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Special'
                                  ),
                                ),
                              ),

                              Center(
                                child: Text(
                                    "Every "+map.values.elementAt(index)['interval']+" Hours"
                                ),
                              ),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text(
                                        "Click Here for More Details"
                                    ),
                                    onPressed: () {

                                      print(map.values.elementAt(index));

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) => CupertinoPopupSurface(
                                              child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 20.0),
                                                    child: Text(
                                                      "This is a Cupertino Popup Surface...",
                                                      style: TextStyle(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 20.0
                                                      ),
                                                    ),
                                                  )
                                              )
                                          )
                                      );
                                    },
                                    color: Colors.amberAccent,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),


      ],
    );
  }

  Widget visitDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: FirebaseAnimatedList(
              query: reference.child("Doctors Visited"),
              itemBuilder:  (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                print(snapshot.value);
                if(snapshot == null) {
                  return Center(
                    child: Text(
                      "You havnt visited any doctors yet :)"
                    ),
                  );
                }

                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.value['Doc name']
                    ),
                  ),
                );
              }
          ),
        ),

        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NewEntry(widget.user)));
          },
        ),
      ],
    );
  }

  Widget notifications() {
    return Center(
      child: Icon(Icons.notifications),
    );
  }
}







