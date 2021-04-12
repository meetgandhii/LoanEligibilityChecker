import 'package:flutter/material.dart';
import 'widgets.dart';
import 'MyProfile.dart';
import 'const.dart';

class LoanChecker extends StatefulWidget {
  @override
  _LoanCheckerState createState() => _LoanCheckerState();
}
int i = 0;
class _LoanCheckerState extends State<LoanChecker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Startbar(
            appbartext: 'Loan Eligibility Checker',
            child: Container(
              margin: EdgeInsets.only(top: 100),
              // width: 250,
              child: Column(
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
                      decoration:
                          InputDecoration(labelText: "Enter the Loan Amount"),
                    ),
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          i++;
                          if (i%2==1)
                          loanStatus = 'Loan is approved';
                          else 
                          loanStatus = 'Loan is rejected';
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
                  Container(
                    child: Details(
                      name: 'Loan Status: ' + loanStatus,
                      size: 15.0,
                      align: Alignment.topCenter,
                    ),
                  ),
                ],
              ),
            )),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
