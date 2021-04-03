import 'package:flutter/material.dart'; 
import 'package:logindemo/Welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // primaryColor: Colors.white
          ),
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
