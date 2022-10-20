import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karma_app/view/login.dart';
import 'package:karma_app/view/register.dart';
import 'view/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //dynamic token = FlutterSession().get('token');
  dynamic token = '';

  runApp(MaterialApp(
    home: token != '' ? DashBoard() : MyApp(),
  ));
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var email = prefs.getString('res');
//   print(email);
//   runApp(MaterialApp(home: email == null ? DashBoard() : MyApp()));
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
     return Container();
  }
}
