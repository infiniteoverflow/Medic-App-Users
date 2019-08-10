import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import 'medicines_prescribed.dart';

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

                  if(map == null) {
                    return Center(
                      child: Text(
                        "No Doctors Visted Yet :)"
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
                                      "Doctor : "+map.values.elementAt(index)['Doc name']
                                          .toString()[0].toUpperCase()+
                                          map.values.elementAt(index)['Doc name']
                                              .toString().substring(1) ,
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
                                                        map.values.elementAt(index)['Doc name']
                                                        .toString()[0].toUpperCase()+
                                                        map.values.elementAt(index)['Doc name']
                                                        .toString().substring(1),
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
                                                ),


                                                GestureDetector(
                                                  child: Card(
                                                    child: ListTile(
                                                      title: Text(
                                                        "Medicines prescribed",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.orangeAccent
                                                        ),
                                                      ),

                                                      trailing: Icon(Icons.navigate_next,size: 30,color: Colors.red,),
                                                    ),
                                                  ),

                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (BuildContext context) => MedicinePresc(
                                                            widget.user,
                                                            map.keys.elementAt(index)
                                                        )
                                                    ));
                                                  },
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(top: 20),
                                                ),
                                                
                                                
                                                Center(
                                                  child: SizedBox(
                                                    height: 40,
                                                    width: 170,
                                                    child: RaisedButton(
                                                      child: Text(
                                                        "Delete this Visit",
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

                                                                        reference.child("Doctors Visited")
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
                                                          borderRadius: BorderRadius.circular(20)
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                
                                                Padding(
                                                  padding: EdgeInsets.all(20),
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