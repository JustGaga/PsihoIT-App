import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:psiho_it_app/resultpage.dart';


class getjson extends StatelessWidget {



  String langname;
  String id;
  getjson(this.langname, this.id);
  String assettoload;

  setasset() {
    if (langname == "Scenariu1") {
      assettoload = "assets/scenariu1.json";
    } else if (langname == "Scenariu2") {
      assettoload = "assets/scenariu2.json";
    } else if (langname == "Scenariu3") {
      assettoload = "assets/scenariu3.json";
    } else if (langname == "Scenariu4") {
      assettoload = "assets/scenariu4.json";
    } else {
      assettoload = "assets/scenariu5.json";
    }
  }

  @override
  Widget build(BuildContext context) {

    setasset();

    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assettoload, cache: true),
      builder: (context, snapshot){
        List mydata = json.decode(snapshot.data.toString());
        if(mydata == null){
          return Scaffold(
            body: Center(
              child: Text(
                "Se incarca...",
              ),
            ),
          );
        }else{
          return quizpage(mydata: mydata, id: id, scenariu: langname);
        }
      },
    );
  }
}

class quizpage extends StatefulWidget {

  var mydata;
  String id;
  String scenariu;
  quizpage({Key key, @required this.mydata, this.id, this.scenariu}) : super(key : key);

  @override
  _quizpageState createState() => _quizpageState(mydata, id, scenariu);
}

class _quizpageState extends State<quizpage> {

  var mydata;
  String id;
  String scenariu;
  _quizpageState(this.mydata, this.id, this.scenariu);

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  int marks = 0;
  int i = 1;
  int timer = 45;
  String showtimer = "45";
  String rezultat = "Ai obtinut: ";

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
  };

  bool canceltimer = false;

  @override
  void initState(){
    starttimer();
    super.initState();
  }


  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t){
      setState(() {
        if(timer < 1){
          t.cancel();
          nextquestion();
        }else if(canceltimer == true){
          t.cancel();
        }else{
          timer =  timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion(){
    canceltimer = false;
    timer = 45;
    setState(() {
      if(i < 5){
        i++;
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (context) => resultpage(rezultat : rezultat, id : id, scenariu : scenariu),
        ));
      }

      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;

    });
    starttimer();
  }


  void checkanswer(String k){
    String mesaj = mydata[2][i.toString()];
    if(k == "a"){
      String toConcat = "+3 $mesaj ";
      rezultat = rezultat + toConcat;
      colortoshow = right;
    }else if(k == "b"){
      String toConcat = "+2 $mesaj ";
      rezultat = rezultat + toConcat;
      colortoshow = right;
    }else if(k == "c"){
      String toConcat = "+1 $mesaj ";
      rezultat = rezultat + toConcat;
      colortoshow = right;
    }

    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
    });

    Timer(Duration(seconds: 1), nextquestion);

  }


  Widget choicebutton(String k){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "Alike",
          ),
        ),
        color: btncolor[k],
        splashColor: Colors.indigoAccent[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Pshiho IT",
            ),
            content: Text(
              "You can't go back at this stage",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Ok",
                )
              )
            ],
          )
        );
      },

      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Quando",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choicebutton('a'),
                    choicebutton('b'),
                    choicebutton('c'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showtimer,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

