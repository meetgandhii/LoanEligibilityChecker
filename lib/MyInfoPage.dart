import 'package:flutter/material.dart';
import 'widgets.dart';
import 'MyProfile.dart';
import 'const.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarandButtonColor,
        title: Text('My Info'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: bgImg, fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyProfile(),
                    ),
                  );
                },
                child: Text('Go back'),
              ),
            ]),
          ),
        ),
      ),
      drawer: DrawerLoan(),
    );
  }
}
