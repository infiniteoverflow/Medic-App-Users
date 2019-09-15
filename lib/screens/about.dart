import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutState();
  }

}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(top: 10),
          ),

          Text(
            "Ashirwad Nursing Home",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Patrick",
              fontSize: 35
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10,left: 25,right: 25),
            child: Card(
              child: Image(
                image: AssetImage("assets/images/hospital/hos2.jpg"),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10,left: 10),
            child: Text(
              "Address :",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "Squada",
                fontSize: 35
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10,left: 10),
            child: Text(
              "Ashirwad Nursing Home,\nLajpat Nagar , \nOpp. Katghar Kotwali\n"
                  "Moradabad , UP",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Special",
                  fontSize: 25
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:20,left: 10),
            child: ListTile(
              leading: Icon(Icons.fiber_manual_record,color: Colors.black,),
              title: Text(
                "A well Known Multispeciality hospital continuosly serving "
                "moradabad and nearby vicinity",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:20,left: 10),
            child: ListTile(
              leading: Icon(Icons.fiber_manual_record,color: Colors.black,),
              title: Text(
                "A well Trusted hospital for all specialities",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),


        ],
      )
    );
  }

}