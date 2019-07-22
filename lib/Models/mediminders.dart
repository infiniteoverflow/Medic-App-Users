import 'package:firebase_database/firebase_database.dart';

class Mediminders {
  String medicineName;
  String dosage;
  String type;
  String interval;
  String startTime;

  Mediminders.fromSnapshot(DataSnapshot snapshot) :
    medicineName = snapshot.value["mediname"],
    dosage = snapshot.value["dosage"],
    type = snapshot.value["type"],
    interval = snapshot.value["interval"],
    startTime = snapshot.value["strattime"];


  toJson() {
    return {
      "mediname" : medicineName,
      "dosage"   : dosage,
      "type"     : type,
      "interval" : interval,
      "starttime": startTime
    };
  }
}