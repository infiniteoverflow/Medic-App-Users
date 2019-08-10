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
                    map.forEach((dynamic, v) => print(v["pic"]));


                    return ListView(
                      children: <Widget>[
                        GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1),
                          itemCount: map.values.toList().length,
                          padding: EdgeInsets.all(2.0),
                          itemBuilder: (BuildContext context, int index) {

                            print(map.values);
                            return Padding(
                              padding: EdgeInsets.only(left: 40,right: 40),
                              child: Card(
                                  child: GestureDetector(
                                    child: ListTile(
                                      title: Text(
                                        map.values.elementAt(index)['name'].toString().toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Special'
                                        ),
                                      ),

                                      subtitle: ListView(
                                        children: <Widget>[

                                          Padding(
                                            padding: EdgeInsets.all(10),
                                          ),

                                          Text(
                                            "Note :",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red
                                            ),
                                          ),
                                          
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                          ),

                                          Text(
                                            map.values.elementAt(index)['note'].toString().toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.orange
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.all(10),
                                          ),

                                          Text(
                                            "Start Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.green
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.all(5),
                                          ),

                                          Text(
                                            map.values.elementAt(index)['startDate'],
                                            style: TextStyle(
                                              color: Colors.deepOrange
                                            ),
                                          ),


                                          Padding(
                                            padding: EdgeInsets.all(10),
                                          ),

                                          Text(
                                            "End Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.green
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.all(5),
                                          ),

                                          Text(
                                            map.values.elementAt(index)['endDate'],
                                            style: TextStyle(
                                                color: Colors.deepOrange
                                            ),
                                          ),


                                          Padding(
                                            padding: EdgeInsets.all(10),
                                          ),

                                          Text(
                                            "Daily Dose",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.green
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.all(5),
                                          ),

                                          Text(
                                            map.values.elementAt(index)['dailyDose'].toString(),
                                            style: TextStyle(
                                                color: Colors.deepOrange
                                            ),
                                          )
                                        ],
                                      ),

                                      trailing: Icon(Icons.delete,color: Colors.red,),
                                    ),
                                  )
                              ),
                            );
                          },
                        ),
                      ],
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