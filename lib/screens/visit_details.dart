import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class VisitDetails extends StatefulWidget {

   FirebaseUser user;

   VisitDetails(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VisitDetailsState();
  }

}

class VisitDetailsState extends State<VisitDetails> {

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference reference;


  @override
  void initState() {
    reference = database.reference().child("Patients").child(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Flexible(
          child: StreamBuilder(
              stream: reference.child("Doctors Visited").onValue,
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

                        print(map.values);
                        return SizedBox(
                          child: Card(
                            elevation: 10,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListView(
                              children: <Widget>[

                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text(
                                      "Doctor : "+map.values.elementAt(index)['Doc name'],
                                      style: TextStyle(
                                          fontFamily: 'Special',
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Visited On :\n ',
                                        style: TextStyle(
                                          fontFamily: 'Special',
                                          fontSize: 20
                                        ),// default text style
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: map.values.elementAt(index)['Visited on'],
                                              style: TextStyle(
                                                fontFamily: 'Special',
                                                fontSize: 20,
                                                color: Colors.amber
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Purpose:\n ',
                                        style: TextStyle(
                                            fontFamily: 'Special',
                                            fontSize: 20
                                        ),// default text style
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: map.values.elementAt(index)['purpose'],
                                              style: TextStyle(
                                                  fontFamily: 'Special',
                                                  fontSize: 20,
                                                  color: Colors.amber
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),


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

                                                Card(
                                                  child: ListTile(
                                                    title: Text(
                                                      "Doctor name",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20
                                                      ),
                                                    ),

                                                    subtitle: Padding(
                                                      padding: EdgeInsets.only(top: 10),
                                                      child: Text(
                                                        map.values.elementAt(index)['Doc name'],
                                                        style: TextStyle(
                                                            fontFamily: 'Special',
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15
                                                        ),
                                                      ),
                                                    )
                                                  ),
                                                ),


                                                Card(
                                                  child: ListTile(
                                                      title: Text(
                                                        "Doctor Email",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20
                                                        ),
                                                      ),

                                                      subtitle: Padding(
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          map.values.elementAt(index)['Doc email'],
                                                          style: TextStyle(
                                                              fontFamily: 'Special',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ),


                                                Card(
                                                  child: ListTile(
                                                      title: Text(
                                                        "Visited on",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20
                                                        ),
                                                      ),

                                                      subtitle: Padding(
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          map.values.elementAt(index)['Visited on'],
                                                          style: TextStyle(
                                                              fontFamily: 'Special',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ),


                                                Card(
                                                  child: ListTile(
                                                      title: Text(
                                                        "Next Appointment",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20
                                                        ),
                                                      ),

                                                      subtitle: Padding(
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          map.values.elementAt(index)['Next Appointment'],
                                                          style: TextStyle(
                                                              fontFamily: 'Special',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ),


                                                Card(
                                                  child: ListTile(
                                                      title: Text(
                                                        "Purpose of Visit",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20
                                                        ),
                                                      ),

                                                      subtitle: Padding(
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          map.values.elementAt(index)['purpose'],
                                                          style: TextStyle(
                                                              fontFamily: 'Special',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ),


                                                Card(
                                                  child: ListTile(
                                                      title: Text(
                                                        "Room Alloted",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20
                                                        ),
                                                      ),

                                                      subtitle: Padding(
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          map.values.elementAt(index)['Room Alloted'],
                                                          style: TextStyle(
                                                              fontFamily: 'Special',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                )

                                              ],
                                            )
                                        )
                                    );
                                  },
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
    ),
    );
  }

}