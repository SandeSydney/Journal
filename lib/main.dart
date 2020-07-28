import 'package:flutter/material.dart';
import 'package:journal/pages/home.dart';

// main method of the program
void main() => runApp(MyApp());

// root of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Home(),
    );
  }
}
