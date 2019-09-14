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
          )

        ],
      )
    );
  }

}