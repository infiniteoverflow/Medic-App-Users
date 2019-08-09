import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MedicinePresc extends StatefulWidget {

  FirebaseUser user;

  MedicinePresc(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MedicinePrescState();
  }

}

class MedicinePrescState extends State<MedicinePresc> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medicines Prescribed"
        ),
      ),

      body: Center(
        child: Text(
          "Hello"
        ),
      ),
    );
  }

}