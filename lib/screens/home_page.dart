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
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            UserAccountsDrawerHeader (
              accountName: Text(this.name),
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

  Widget mediminder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: FirebaseAnimatedList(
              query: database.reference().child("Patients").child(widget.user.uid).child("Mediminders"),
              itemBuilder:  (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                if(snapshot == null) {
                  return Center(
                    child: Text(
                      "You dont hav any mediminders yet :("
                    ),
                  );
                }

                return Card(
                  child: ListTile(
                      title: Text(
                          snapshot.value['mediname']
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Text(
                              snapshot.value['starttime']
                          ),
                          Text(
                              snapshot.value['dosage']
                          ),
                          Text(
                              snapshot.value['interval']
                          ),
                          Text(
                              snapshot.value['type']
                          )
                        ],
                      )
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







