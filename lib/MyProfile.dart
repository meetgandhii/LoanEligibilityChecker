import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'widgets.dart';
import 'package:logindemo/AddMoreDocs.dart';
import 'package:logindemo/HomePage.dart';
// import 'package:logindemo/Signin.dart';
import 'MyInfoPage.dart';
import 'ViewCreditScore.dart';
import 'AddMoreDocs.dart';
import 'const.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        backgroundColor: appBarandButtonColor,
        title: Text("My Profile"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: bgImg, fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image:
                    //         fit: BoxFit.cover)),

                    width: double.infinity,
                    // height: 120,

                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      backgroundImage: profileImage,
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Meet Gandhi",
                style: TextStyle(
                    fontSize: 25.0,
                    color: textColor,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                        color: shadowColor,
                      ),
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                        color: shadowColor,
                      ),
                    ],
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: appBarandButtonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyInfoPage(),
                        ),
                      );
                    },
                    child: Text(
                      'View My Info',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: appBarandButtonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewCreditScore(),
                        ),
                      );
                    },
                    child: Text(
                      'View Credit Score',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // SizedBox(
              //   height: 15,
              // ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: appBarandButtonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMoreDocs(),
                        ),
                      );
                    },
                    child: Text(
                      'Add more docs',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // SizedBox(
              //   height: 15,
              // ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: appBarandButtonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage(),
                        ),
                      );
                    },
                    child: Text(
                      'Go back to home page',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerLoan(),
    );
  }
}
