import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medic_app_users/Models/medicines.dart';
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

  //  String name;

  void initState() {
    super.initState();
    reference = database.reference().child("Patients").child(widget.user.uid);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medic App"
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: FirebaseAnimatedList(
                query: reference.child("Mediminders"),
                itemBuilder:  (_, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  print(snapshot.value);
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
        ],
      )
    );
  }
}

//else if (snapshot.data.length == 0) {
//return Container(
//color: Color(0xFFF6F8FC),
//child: Center(
//child: Text(
//"Press + to add a Mediminder",
//textAlign: TextAlign.center,
//style: TextStyle(
//fontSize: 24,
//color: Color(0xFFC9C9C9),
//fontWeight: FontWeight.bold),
//),
//),
//);
//}



//else {
//return Container(
//color: Color(0xFFF6F8FC),
//child: GridView.builder(
//padding: EdgeInsets.only(top: 12),
//gridDelegate:
//SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//itemCount: snapshot.data.length,
//itemBuilder: (context, index) {
//return MedicineCard(snapshot.data[index]);
//},
//),
//);
//}


//class MedicineCard extends StatelessWidget {
//  final Medicine medicine;
//
//  MedicineCard(this.medicine);
//
//  Hero makeIcon(double size) {
//    if (medicine.medicineType == "Bottle") {
//      return Hero(
//        tag: medicine.medicineName + medicine.medicineType,
//        child: Icon(
//          IconData(0xe900, fontFamily: "Ic"),
//          color: Color(0xFF3EB16F),
//          size: size,
//        ),
//      );
//    } else if (medicine.medicineType == "Pill") {
//      return Hero(
//        tag: medicine.medicineName + medicine.medicineType,
//        child: Icon(
//          IconData(0xe901, fontFamily: "Ic"),
//          color: Color(0xFF3EB16F),
//          size: size,
//        ),
//      );
//    } else if (medicine.medicineType == "Syringe") {
//      return Hero(
//        tag: medicine.medicineName + medicine.medicineType,
//        child: Icon(
//          IconData(0xe902, fontFamily: "Ic"),
//          color: Color(0xFF3EB16F),
//          size: size,
//        ),
//      );
//    } else if (medicine.medicineType == "Tablet") {
//      return Hero(
//        tag: medicine.medicineName + medicine.medicineType,
//        child: Icon(
//          IconData(0xe903, fontFamily: "Ic"),
//          color: Color(0xFF3EB16F),
//          size: size,
//        ),
//      );
//    }
//    return Hero(
//      tag: medicine.medicineName + medicine.medicineType,
//      child: Icon(
//        Icons.error,
//        color: Color(0xFF3EB16F),
//        size: size,
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.all(10.0),
//      child: InkWell(
//        highlightColor: Colors.white,
//        splashColor: Colors.grey,
//        onTap: () {
//          Navigator.of(context).push(
//            PageRouteBuilder<Null>(
//              pageBuilder: (BuildContext context, Animation<double> animation,
//                  Animation<double> secondaryAnimation) {
//                return AnimatedBuilder(
//                    animation: animation,
//                    builder: (BuildContext context, Widget child) {
//                      return Opacity(
//                        opacity: animation.value,
//                        child: MedicineDetails(medicine),
//                      );
//                    });
//              },
//              transitionDuration: Duration(milliseconds: 500),
//            ),
//          );
//        },
//        child: Container(
//          decoration: BoxDecoration(
//            color: Colors.white,
//            borderRadius: BorderRadius.circular(15),
//          ),
//          child: Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                makeIcon(50.0),
//                Hero(
//                  tag: medicine.medicineName,
//                  child: Material(
//                    color: Colors.transparent,
//                    child: Text(
//                      medicine.medicineName,
//                      style: TextStyle(
//                          fontSize: 22,
//                          color: Color(0xFF3EB16F),
//                          fontWeight: FontWeight.w500),
//                    ),
//                  ),
//                ),
//                Text(
//                  medicine.interval == 1
//                      ? "Every " + medicine.interval.toString() + " hour"
//                      : "Every " + medicine.interval.toString() + " hours",
//                  style: TextStyle(
//                      fontSize: 16,
//                      color: Color(0xFFC9C9C9),
//                      fontWeight: FontWeight.w400),
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

// class MiddleContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
//     return StreamBuilder<Object>(
//         stream: globalBloc.selectedDay$,
//         builder: (context, snapshot) {
//           return Container(
//             height: double.infinity,
//             width: double.infinity,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Saturday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Sat",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Saturday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Sunday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Sun",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Sunday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Monday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Mon",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Monday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Tuesday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Tue",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Tuesday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Wednesday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Wed",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Wednesday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Thursday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Thu",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Thursday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Friday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Fri",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Friday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }





