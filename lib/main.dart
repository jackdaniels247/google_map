// @dart=2.9
import 'package:authenticator_app/home.dart';
import 'package:authenticator_app/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dataHandler/appData.dart';
//import 'login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>AppData(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home(),
    ),
    );
  }
}

