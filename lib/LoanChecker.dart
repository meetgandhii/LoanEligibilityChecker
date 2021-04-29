import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets.dart';
import 'MyProfile.dart';
import 'const.dart';

class LoanChecker extends StatefulWidget {
  @override
  _LoanCheckerState createState() => _LoanCheckerState();
}

class _LoanCheckerState extends State<LoanChecker> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final infoValid = MultiValidator([
    RequiredValidator(errorText: 'info is required'),
    // PatternValidator(
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    //     errorText: 'enter valid info')
  ]);
  String error = '';
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
                  name: 'Loan Status: ' +
                      '                                     ' +
                      loanStatusvar,
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
              Form(
                key: _formKey2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                children: [
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 00, right: 40, left: 40),
                    // margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      validator: infoValid,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      controller: lcloanAmtController,
                      decoration:
                          InputDecoration(labelText: "Enter the Loan Amount"),
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 00, right: 20, left: 20),
                    // margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      validator: infoValid,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      controller: lcloanDurationController,
                      decoration: InputDecoration(
                          labelText: "Enter the Loan Duration in days"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      error,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                        color: Colors.red,
                        backgroundColor: Colors.grey[100],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: RaisedButton(
                      onPressed: () async {
                        if (lcloanAmtController.text != '' &&
                            lcloanDurationController.text != '') {
                          print('ok');
                          User user = _auth.currentUser;
                          // String userId = (FirebaseAuth.instance.currentUser).uid;
                          await _firestore
                              .collection("users")
                              .doc(user.uid)
                              .update({
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
                        } else {
                          setState(() {
                            error =
                                'One or more fields have been left blank. Please fill out all info';
                          });
                          print('not ok');
                        }
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
              )),
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
