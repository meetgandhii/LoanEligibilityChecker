import 'package:flutter/material.dart';
import 'DocumentSubmit.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'const.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        backgroundColor: appBarandButtonColor,
        title: Text("Signup Page"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: bgImg, fit: BoxFit.cover),
        ),
        // child: TextField(
        //   decoration: InputDecoration(fillColor: Colors.amber, filled: true),
        // ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                    width: 250,
                    height: 150,
                    child: Image.asset(loanImage),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter valid name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: Container(
                  width: 15000.0,
                  height: 50.0,
                  child: OutlineButton(
                    child: Text(
                      dobText,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1921, 1, 1),
                          maxTime: DateTime(2021, 31, 12), onChanged: (date) {
                        // print('change $date');
                      }, onConfirm: (date) {
                        dt = date.day.toString();
                        mnth = date.month.toString();
                        yr = date.year.toString();
                        if (dt.length == 1) {
                          dt = '0' + dt;
                        }
                        if (mnth.length == 1) {
                          mnth = '0' + mnth;
                        }
                        dob = dt + '-' + mnth + '-' + yr;
                        setState(() {
                          dobText = dob;
                        });
                        // print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter valid email id'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter password'),
                ),
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
                      print('Name: ' + nameController.text);
                      // print(dobController.text);
                      print('DOB: ' + dobText);
                      print('Email: ' + emailController.text);
                      print('Password: ' + passwordController.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DocumentSubmit()));
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
