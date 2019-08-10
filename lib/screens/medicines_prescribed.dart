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
                stream: reference.child("Doctors Visited").child(widget.docUID).onValue,
                builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    map.forEach((dynamic, v) => print(v["pic"]));


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
                          return Text(
                            "Hello"
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