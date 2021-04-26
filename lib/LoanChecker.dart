import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import 'MyProfile.dart';
import 'const.dart';

class LoanChecker extends StatefulWidget {
  @override
  _LoanCheckerState createState() => _LoanCheckerState();
}



class _LoanCheckerState extends State<LoanChecker> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    String userId = (FirebaseAuth.instance.currentUser).uid;
    
    return FutureBuilder(
      future: _firestore.collection('users').doc(userId).get(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var userdata = snapshot.data.data();
        String loanStatus = userdata['Loan Status'];
        String loanStatusvar = loanStatus;
        int i = userdata['Has applied'];
        var presubmit;
        if (i == 1) {
          presubmit = Column(
            children: [
              Container(
                child: Details(
                  name: 'Loan Status: ' +'                                     '+ loanStatusvar,
                  size: 22.5,
                  align: Alignment.topLeft,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh Loan Status',
                  onPressed: () {
                    setState(() {
                      loanStatusvar = loanStatus;
                    });
                  }),
            ],
          );
        }
        if (i != 1) {
          presubmit = Column(
            children: [
              Image.asset(
                'assets/images/check.png',
                width: 250,
              ),
              Container(
                width: 200,
                margin: EdgeInsets.only(top: 00, right: 40, left: 40),
                // margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: lcloanAmtController,
                  decoration:
                      InputDecoration(labelText: "Enter the Loan Amount"),
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 00, right: 20, left: 20),
                // margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: lcloanDurationController,
                  decoration: InputDecoration(
                      labelText: "Enter the Loan Duration in days"),
                ),
              ),
              Container(
                width: 150,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: 40, right: 40, top: 40),
                child: RaisedButton(
                  onPressed: () async {
                    User user = _auth.currentUser;
                    // String userId = (FirebaseAuth.instance.currentUser).uid;
                    await _firestore.collection("users").doc(user.uid).update({
                      'Loan Amount': lcloanAmtController.text,
                      'Loan Duration': lcloanDurationController.text,
                      'Loan Status': 'Waiting for approval',
                      'Has applied': 1,
                    });
                    setState(() {
                      // Navigator.push(
                      // context, MaterialPageRoute(builder: (_) => Loader()));
                      // Navigator.pop(context);
                      // i++;
                      i = 1;
                      loanStatusvar = loanStatus;
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    // width: size.width * 0.5,
                    decoration: boxDesign(),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "Submit",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Scaffold(
          body: Startbar(
              appbartext: 'Loan Eligibility Checker',
              child: Container(
                margin: EdgeInsets.only(top: 100),
                // width: 250,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      presubmit,
                    ],
                  ),
                ),
              )),
          bottomNavigationBar: BottomNavigation(),
        );
      },
    );
  }
}
