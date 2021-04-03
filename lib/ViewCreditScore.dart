import 'package:flutter/material.dart'; 
import 'widgets.dart';
import 'MyProfile.dart';
import 'const.dart';

class ViewCreditScore extends StatefulWidget {
  @override
  _ViewCreditScoreState createState() => _ViewCreditScoreState();
}

class _ViewCreditScoreState extends State<ViewCreditScore> {
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
