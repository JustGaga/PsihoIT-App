import 'package:flutter/material.dart';
import 'package:psiho_it_app/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Psiho IT',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: splashscreen(),
    );
  }
}

