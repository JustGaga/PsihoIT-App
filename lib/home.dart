import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psiho_it_app/quizpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';


class homepage extends StatefulWidget {


  final String id;

  homepage({this.id});
  @override
  _homepageState createState() => _homepageState(id);
}

class _homepageState extends State<homepage> {


  final db = Firestore.instance;
  String id;
  _homepageState(this.id);

  List<String> images = [
    "images/py.png",
    "images/java.png",
    "images/js.png",
    "images/cpp.png",
    "images/linux.png",
  ];

  List<String> des = [
    "Descriere scenariu 1",
    "Descriere scenariu 2",
    "Descriere scenariu 3",
    "Descriere scenariu 4",
    "Descriere scenariu 5",
  ];


  _launchURL() async {
    const url = 'https://docs.google.com/forms/d/e/1FAIpQLSf6H1od2cwsHx0MsbJhPVykMedHpvdnRpqluHNQsclr1a32xA/viewform?usp=sf_link';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  Widget customcard(String quizName, String image, String des){

    return Padding(
      padding: EdgeInsets.all(
        20.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getjson(quizName, id),
          ));
        },
        child: Material(
          color: Colors.indigoAccent,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),

                    child: Text(
                      quizName,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontFamily: "Alike",
                        fontWeight: FontWeight.w700,
                      )
                    ),
                  ),
                ),
//                Container(
//                  padding: EdgeInsets.all(20.0),
//                )
              ],
            ),
          ),
        )
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp,
    ]);


    String showID = "ID: " + id;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Psiho IT",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Text(
            showID,
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),

          Padding(
            padding:EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Text(
              "Mai jos gasesti 5 situatii de viata, in care te-ai gasit sau te poti gasi oricand. Tu esti protagonistul, alege reactia la fiecare situatie in acord cu felul tau de a fi! Raspunde sincer si spontan, timpul este limitat!",
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: "Alike",
              ),
            ),
          ),
          customcard("Scenariu1", images[0], des[0]),
          customcard("Scenariu2", images[1], des[1]),
          customcard("Scenariu3", images[2], des[2]),
          customcard("Scenariu4", images[3], des[3]),
          customcard("Scenariu5", images[4], des[4]),
          Text(
            showID,
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          Padding(
            padding:EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Text(
              "Dupa ce termini cele 5 scenarii, retine ID-ul unic afisat aici si apasa pe butonul ”Chestionar” pentru a completa formularul de final!",
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: "Alike",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 70.0,
            ),

           child: MaterialButton(
            onPressed: _launchURL,
            elevation: 3.0,
            color:Colors.indigoAccent[700],
            minWidth: 200,
            splashColor: Colors.indigoAccent[700],
            highlightColor: Colors.indigo[700],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: new Text(
                'Chestionar',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Alike",
                  fontSize: 20.0,
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

