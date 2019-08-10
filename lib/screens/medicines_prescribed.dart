import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class MedicinePresc extends StatefulWidget {

  FirebaseUser user;
  String docUID;
  MedicinePresc(this.user,this.docUID);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MedicinePrescState();
  }

}

class MedicinePrescState extends State<MedicinePresc> {

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

      appBar: AppBar(
        title: Text(
          "Medicines Prescribed"
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Flexible(
            child: StreamBuilder(
                stream: reference.child("Doctors Visited").child(widget.docUID).child("Medicines Prescribed").onValue,
                builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {

                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

                    if(map == null) {
                      return Center(
                        child: Text(
                            "No Medicines :("
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
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: ListView(
                                children: <Widget>[

                                  Padding(
                                    padding: EdgeInsets.only(top: 10,right: 5,left: 5),
                                    child: Center(
                                      child: Text(
                                        map.values.elementAt(index)['name'].toString().toUpperCase(),
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Special',
                                            fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Daily Dosage :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                        fontSize: 20
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        map.values.elementAt(index)['dailyDose'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green
                                        ),
                                      ),
                                    )
                                  ),


                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                      child: IconButton(
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
                                                                "Medicine name",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 20
                                                                ),
                                                              ),

                                                              subtitle: Padding(
                                                                padding: EdgeInsets.only(top: 10),
                                                                child: Text(
                                                                  map.values.elementAt(index)['name']
                                                                      .toString()[0].toUpperCase()+
                                                                  map.values.elementAt(index)['name']
                                                                  .toString().substring(1),
                                                                  style: TextStyle(
                                                                      fontFamily: 'Special',
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 18
                                                                  ),
                                                                ),
                                                              )
                                                          ),
                                                        ),


                                                        Card(
                                                          child: ListTile(
                                                              title: Text(
                                                                "Note",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 20
                                                                ),
                                                              ),

                                                              subtitle: Padding(
                                                                padding: EdgeInsets.only(top: 10),
                                                                child: Text(
                                                                  map.values.elementAt(index)['note'],
                                                                  softWrap: true,
                                                                  style: TextStyle(
                                                                      fontFamily: 'Special',
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15
                                                                  ),
                                                                ),
                                                              )
                                                          ),
                                                        ),
//
//
                                                        Card(
                                                          child: ListTile(
                                                              title: Text(
                                                                "Daily Dosage",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 20
                                                                ),
                                                              ),

                                                              subtitle: Padding(
                                                                padding: EdgeInsets.only(top: 10),
                                                                child: Text(
                                                                  map.values.elementAt(index)['dailyDose'].toString(),
                                                                  style: TextStyle(
                                                                      fontFamily: 'Special',
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15
                                                                  ),
                                                                ),
                                                              )
                                                          ),
                                                        ),
//
//
                                                        Card(
                                                          child: ListTile(
                                                              title: Text(
                                                                "Start Date",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 20
                                                                ),
                                                              ),

                                                              subtitle: Padding(
                                                                padding: EdgeInsets.only(top: 10),
                                                                child: Text(
                                                                  map.values.elementAt(index)['startDate'],
                                                                  style: TextStyle(
                                                                      fontFamily: 'Special',
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15
                                                                  ),
                                                                ),
                                                              )
                                                          ),
                                                        ),
//
//
                                                        Card(
                                                          child: ListTile(
                                                              title: Text(
                                                                "End Date",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 20
                                                                ),
                                                              ),

                                                              subtitle: Padding(
                                                                padding: EdgeInsets.only(top: 10),
                                                                child: Text(
                                                                  map.values.elementAt(index)['endDate'],
                                                                  style: TextStyle(
                                                                      fontFamily: 'Special',
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15
                                                                  ),
                                                                ),
                                                              )
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: EdgeInsets.all(10),
                                                        ),

                                                        Center(
                                                          child: RaisedButton(
                                                            shape: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(30)
                                                            ),
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


                                                                              reference.child("Doctors Visited")
                                                                                  .child(widget.docUID)
                                                                                  .child("Medicines Prescribed")
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
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                )
                                            );
                                          }
                                      ),
                                    ),
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