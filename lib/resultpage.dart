//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:psiho_it_app/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class resultpage extends StatefulWidget {
  String rezultat;
  String id;
  String scenariu;
  resultpage({Key key, @required this.rezultat, this.id, this.scenariu}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(rezultat, id, scenariu);
}

class _resultpageState extends State<resultpage> {

  List<String> images = [
    "images/succes.png",
    "images/good.png",
    "images/good.png",
  ];

  String message;
  String image;

  @override
  void initState(){
  image = images[1];


  super.initState();
}

  String rezultat;
  String id;
  String scenariu;
  _resultpageState(this.rezultat, this.id, this.scenariu);
  final db = Firestore.instance;

  void updateDB () async{

    String updated = rezultat.substring(12);

    DocumentSnapshot snapshot = await db
        .collection('users')
        .document(id)
        .get();
    await db
        .collection('users')
        .document(id)
        .updateData({
      scenariu : updated
    });


  }


  @override
  Widget build(BuildContext context) {
    updateDB();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rezultat",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 25.0,
                      ),
                      child: Center(
                        child: Text(
                          rezultat,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Quando",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => homepage(id : id),
                    ));
                  },
                  child: Text(
                    "Continua",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
