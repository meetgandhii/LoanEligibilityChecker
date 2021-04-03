import 'package:flutter/material.dart';
import 'Signin.dart';
import 'LoginPage.dart';
import 'const.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

Color inactiveColor = Color.fromRGBO(24, 49, 213, 0.55);
Color buttonColor1 = inactiveColor;
Color buttonColor2 = inactiveColor;

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: bgImg, fit: BoxFit.cover),
        ),
        // child: TextField(
        //   decoration: InputDecoration(fillColor: Colors.amber, filled: true),
        // ),
        child: Center(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: buttonColor1,
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          buttonColor1 = appBarandButtonColor;
                          buttonColor2 = inactiveColor;
                          
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Signin()));
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                  width: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: buttonColor2,
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          buttonColor2 = appBarandButtonColor;
                          buttonColor1 = inactiveColor;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
