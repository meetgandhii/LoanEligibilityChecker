import 'package:flutter/material.dart'; 
import 'widgets.dart';
import 'package:logindemo/ContactUs.dart';
import 'MyProfile.dart';
import 'LoanChecker.dart';
import 'const.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: appBarandButtonColor,
        title: Text('Home Page'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: bgImg, fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 150,
                  decoration: BoxDecoration(
                      color: appBarandButtonColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MyProfile()));
                    },
                    child: Text(
                      'My Profile',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  width: 150,
                  decoration: BoxDecoration(
                      color: appBarandButtonColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoanChecker()));
                    },
                    child: Text(
                      'Loan Checker',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  width: 150,
                  decoration: BoxDecoration(
                      color: appBarandButtonColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ContactUs()));
                    },
                    child: Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: DrawerLoan(),
    );
  }
}
