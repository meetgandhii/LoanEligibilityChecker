import 'package:flutter/material.dart'; 
import 'widgets.dart';
import 'package:logindemo/AboutUs.dart';
import 'package:logindemo/ChatWithUs.dart';
import 'package:logindemo/FAQs.dart';
import 'HomePage.dart';
import 'const.dart';

// import 'LoanChecker.dart';
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: appBarandButtonColor,
        title: Text('Contact Us'),
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
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => FAQs()));
                    },
                    child: Text(
                      'FAQs',
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
                          MaterialPageRoute(builder: (_) => ChatWithUs()));
                    },
                    child: Text(
                      'Chat with us',
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
                          MaterialPageRoute(builder: (_) => AboutUs()));
                    },
                    child: Text(
                      'About Us',
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
                          MaterialPageRoute(builder: (_) => HomePage()));
                    },
                    child: Text(
                      'GO back to homepage',
                      style: TextStyle(color: Colors.white, fontSize: 15),
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
