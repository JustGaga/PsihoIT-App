import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psiho_it_app/home.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}




class _splashscreenState extends State<splashscreen> {

  final db = Firestore.instance;
  String id;


  void setID () async{
    DocumentSnapshot snapshot = await db
        .collection('users')
        .document('id')
        .get();
    snapshot.data['id']++;
    await db
        .collection('users')
        .document('id')
        .setData({
      'id': snapshot.data['id']
    });
    await db
        .collection('users')
        .document((snapshot.data['id'].toString()))
        .setData({
      'id': snapshot.data['id'].toString(),
      'Scenariu1' : 'necompletat',
      'Scenariu2' : 'necompletat',
      'Scenariu3' : 'necompletat',
      'Scenariu4' : 'necompletat',
      'Scenariu5' : 'necompletat'
    });

    this.id = snapshot.data['id'].toString();
  }

  @override
  void initState(){
    super.initState();
    setID();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => homepage(id: id),
      ));
    });
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          "Pshiho IT",
            style: TextStyle(
              fontSize: 50.0,
              color: Colors.white,
              fontFamily: "Satisfy",
            )
        ),
      )

    );
  }
}
