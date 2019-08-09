import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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

                      subtitle: Text(
                        snapshot.value['purpose']
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

}