import 'package:flutter/material.dart';
import 'LoginPage.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
          ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
