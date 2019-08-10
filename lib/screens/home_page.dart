import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'visit_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:medic_app_users/screens/new_entry.dart';
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
            ),


            Card(
              child: ListTile(
                title: Text(
                  "Call an Ambulance"
                ),
                leading: Icon(Icons.call),
                trailing: Icon(Icons.arrow_forward,color: Colors.black,),
              ),
            ),


            Card(
              child: ListTile(
                title: Text(
                  "Reserve a Room"
                ),
                trailing: Icon(Icons.arrow_forward,color: Colors.black,),
                leading: Icon(Icons.bookmark),
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
        size: 95,
        color: Color(0xFF3EB16F),
      );
    }

    else if(map['type'] == "Bottle") {
      return Icon(
        IconData(0xe900, fontFamily: "Ic"),
        size: 95,
        color: Color(0xFF3EB16F),
      );
    }

    else if(map['type'] == "Pill") {
      return Icon(
        IconData(0xe901, fontFamily: "Ic"),
        size: 95,
        color: Color(0xFF3EB16F),
      );
    }

    return Icon(
      IconData(0xe902, fontFamily: "Ic"),
      size: 95,
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

                  if(map == null) {
                    return Center(
                      child: Text(
                        "No Mediminders Added Yet :)"
                      ),
                    );
                  }

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
                        return SizedBox(
                          child: Card(
                            elevation: 10,
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
                                    IconButton(
                                      icon: Icon(Icons.more_horiz),
                                      onPressed: () {
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

                                                    selectIcon(map.values.elementAt(index)),

                                                    Padding(
                                                      padding: EdgeInsets.all(10),
                                                    ),

                                                    Card(
                                                      child: ListTile(
                                                        title: Text(
                                                          "Medicine Name",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                            map.values.elementAt(index)['mediname']
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.all(5),
                                                    ),

                                                    Card(
                                                      child: ListTile(
                                                        title: Text(
                                                          "Medicine Type",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                            map.values.elementAt(index)['type']
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.all(5),
                                                    ),

                                                    Card(
                                                      child: ListTile(
                                                        title: Text(
                                                          "Dosage",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                            map.values.elementAt(index)['dosage'] + " mg"
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.all(5),
                                                    ),

                                                    Card(
                                                      child: ListTile(
                                                        title: Text(
                                                          "Duration",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                            "Every "+map.values.elementAt(index)['interval']
                                                                +" Hours"
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.all(5),
                                                    ),

                                                    Center(
                                                      child: RaisedButton(
                                                        child: Text(
                                                          "Delete this Medicine",
                                                          style: TextStyle(
                                                              color: Colors.white
                                                          ),
                                                        ),
                                                        color: Colors.red,
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) => CupertinoAlertDialog(
                                                                title: Text(
                                                                  "Are You sure you want to delete this medicine",
                                                                  style: TextStyle(
                                                                      fontSize: 20.0,
                                                                      color: Colors.red
                                                                  ),
                                                                ),
                                                                actions: <Widget>[
                                                                  CupertinoActionSheetAction(
                                                                    onPressed: () {

                                                                    },
                                                                    child: CupertinoButton(
                                                                        color: Colors.red,
                                                                        child: Text(
                                                                          "Delete",
                                                                          style: TextStyle(
                                                                              color: Colors.black
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                          Navigator.pop(context);

                                                                          reference.child("Mediminders")
                                                                              .child(map.keys.toList()[index])
                                                                              .remove();

                                                                          setState(() {

                                                                          });
                                                                        }
                                                                    ),
                                                                  ),

                                                                  CupertinoActionSheetAction(
                                                                    onPressed: () {

                                                                    },
                                                                    child: CupertinoButton(

                                                                        color: Colors.amber,
                                                                        child: Text(
                                                                          "Cancel",
                                                                          style: TextStyle(
                                                                              color: Colors.black
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        }
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                          );
                                                        },
                                                        shape: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(30)
                                                        ),
                                                      ),
                                                    )



                                                  ],
                                                )
                                            )
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
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


  Widget notifications() {
    return Center(
      child: Icon(Icons.notifications),
    );
  }
}







