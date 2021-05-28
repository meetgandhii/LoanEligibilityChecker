import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets.dart';
import 'MyProfile.dart';
import 'WhyRejected.dart';
import 'package:http/http.dart' as http;
import 'const.dart';
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
  var credit;
  var uriResponse1;
  int intaccbal;
  int intinr;
  int intempdur;
  int intage;
  int intappstatus;
  int intccwus;
  int intaocc;
  int intdep;
  int intgen;
  int intselfemp;
  int intmarr;
  int intedulevel;
  int intinc;
  int intcoinc;
  var temp;
  int intloanamt;
  var temp1;
  int intloandur;
  String loanamt;
  String loandur;
  var loanStatusvar;
  // int loanint;
  String loanStatus;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String userId = (FirebaseAuth.instance.currentUser).uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firestore.collection('users').doc(userId).get(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var userdata = snapshot.data.data();
        loanStatus = userdata['Loan Status'];
        String accbal = userdata['Account Balance'];
        loanamt = userdata['Loan Amount'];
        loandur = userdata['Loan Duration'];
        String loanStatusvar = loanStatus;
        int i = userdata['Has applied'];
        int loanint = userdata['LoanInt'];
        intaccbal = int.parse(accbal);
        if (intaccbal > 0 && intaccbal <= 200) {
          intaccbal = 3;
        }
        if (intaccbal == 0) {
          intaccbal = 0;
        }
        if (intaccbal >= 2000) {
          intaccbal = 4;
        }
        String inc = userdata['Applicants income'];

        intinc = int.parse(inc);
        String age = userdata['Age'];
        intage = int.parse(age);
        //'Apartment Status':{'Free apartment':1,'Rented Flat':2,'Own an apartment':3}}
        String appstatus = userdata['Apartment Status'];

        if (appstatus == 'Free apartment') {
          intappstatus = 1;
        }
        if (appstatus == 'Rented Flat') {
          intappstatus = 2;
        }
        if (appstatus == 'Own an apartment') {
          intappstatus = 3;
        }

        var intapp = int.parse("1");
        String selfemp = userdata['Are they self employed'];
        if (selfemp == "No") {
          intselfemp = 0;
        }
        if (selfemp == "Yes") {
          intselfemp = 1;
        }
        String coinc = userdata['Co-applicants income'];
        intcoinc = int.parse(coinc);
        String empdur = userdata['Currently employed from how long'];
        intempdur = int.parse(empdur);
        if (intempdur <= 1) {
          intempdur = 2;
        }
        if (intempdur > 1 && intempdur < 4) {
          intempdur = 3;
        }
        if (intempdur > 4 && intempdur < 7) {
          intempdur = 4;
        }
        if (intempdur >= 7) {
          intempdur = 5;
        }
        if (intempdur == 0) {
          intempdur = 1;
        }

        String edulevel = userdata['Education Level'];
        if (edulevel == "Graduate") {
          intedulevel = 1;
        }
        if (edulevel == "Non graduate") {
          intedulevel = 1;
        }

        String gender = userdata['Gender'];
        if (gender == 'Male') {
          intgen = 1;
        }
        if (gender == 'Female') {
          intgen = 0;
        }

        String marry = userdata['Marriage Status'];
        if (marry == "Yes") {
          intmarr = 1;
        }
        if (marry == "No") {
          intmarr = 2;
        }
        String dependants = userdata['Number of Dependant'];
        intdep = int.parse(dependants);
        if (intdep >= 0 && intdep <= 2) {
          intdep = 2;
        }
        if (intdep > 3) {
          intdep = 1;
        }
        String ccwus = userdata['Number of credit cards at this bank'];
        intccwus = int.parse(ccwus);
        if (intccwus == 2 || intccwus == 3) {
          intccwus = 2;
        }
        if (intccwus == 4 || intccwus == 5) {
          intccwus = 3;
        }
        if (intccwus >= 6) {
          intccwus = 4;
        }
        String ccwothers = userdata['Number of credit cards with other banks'];
        var intccwothers = int.parse(ccwothers);
        //'Occupation':{'Unemployed':1,'Unskilled Employee':2,'Skilled Employee':3,'Self Employed':4
        String occupation = userdata['Occupation'];

        if (occupation == 'Unemployed') {
          intaocc = 1;
        }
        if (occupation == 'Unskilled Employee') {
          intaocc = 2;
        }
        if (occupation == 'Skilled Employee') {
          intaocc = 3;
        }
        if (occupation == 'Self Employed') {
          intaocc = 4;
        }

        // String proparea = userdata['Property Area'];
        // var intcproparea = int.parse(proparea);
        String inr = userdata['Savings in INR'];
        intinr = int.parse(inr);
        if (intinr >= 100 && intinr < 500) {
          intinr = 3;
        }
        if (intinr < 100) {
          intinr = 2;
        }
        if (intinr >= 500 && intinr < 1000) {
          intinr = 4;
        }
        if (intinr >= 1000) {
          intinr = 5;
        }
        if (intinr == 0) {
          intinr = 1;
        }
        String pfp = userdata['Pfp'];

        var presubmit;
        var btnforreject;
        if (loanint == 0) {
          btnforreject = FlatButton(
              onPressed: () {
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WhyRejected()),
                );
              },
              child: Text('Click here to check why you were rejected'));
        } else {
          btnforreject = Text('');
        }
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
                      apicallcredit();
                      loanStatusvar = loanStatus;
                    });
                  }),
              RaisedButton(
                onPressed: () async {
                  User user = _auth.currentUser;
                  // String userId = (FirebaseAuth.instance.currentUser).uid;
                  await _firestore.collection("users").doc(user.uid).update({
                    'Has applied': 0,
                  });
                  setState(() {
                    apicallcredit();
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
                  decoration: boxDesign(),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "CLICK ME TO APPLY FOR A NEW LOAN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
                          decoration: InputDecoration(
                              labelText: "Enter the Loan Amount"),
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
                                apicallcredit();
                              });
                            } else {
                              setState(() {
                                apicallcredit();
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
          apicallcredit();
        }
        return Scaffold(
          body: Startbar(
              appbartext: 'Loan Eligibility Checker',
              child: Container(
                margin: EdgeInsets.only(top: 100),
                // width: 250,
                child: SingleChildScrollView(
                  child: Column(
                    children: [presubmit, btnforreject],
                  ),
                ),
              )),
          bottomNavigationBar: BottomNavigation(),
        );
      },
    );
  }

  Future apicallcredit() async {
    //   https://bb05a26c8be2.ngrok.io
    var uri = Uri.https("bb05a26c8be2.ngrok.io", "/credit");
    print(uri);
    //var url = "192.168.0.105:8000/credit";
    // Map data = {
    //   'Account Balance': [intaccbal],
    //   'Duration of Credit (month)': 0,
    //   'Payment Status of Previous Credit': 0,
    //   'Credit Amount': 1049,
    //   'Value Savings/Stocks': intinr,
    //   'Length of current employment': intempdur,
    //   'Age (years)': intage,
    //   'Concurrent Credits': 3,
    //   'Type of apartment': intappstatus,
    //   'No of Credits at this Bank': intccwus,
    //   'Occupation': intaocc,
    //   'No of dependents': intdep
    // };
    http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'Account Balance': intaccbal,
          'Duration of Credit (month)': 0,
          'Payment Status of Previous Credit': 0,
          'Credit Amount': 1049,
          'Value Savings/Stocks': intinr,
          'Length of current employment': intempdur,
          'Age (years)': intage,
          'Concurrent Credits': 3,
          'Type of apartment': intappstatus,
          'No of Credits at this Bank': intccwus,
          'Occupation': intaocc,
          'No of dependents': intdep
        }));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson.toString() == "{prediction: [1]}") {
        print("credit score positive");
        credit = 1;
      }
      if (responseJson.toString() == "{prediction: [0]}") {
        print("credit score negative");
        credit = 0;
      }
      print("success");
      apiLoancall();
    } else {
      print(intaccbal);
      print(intappstatus);
      print(intaocc);
      print(intccwus);
      print(intdep);
      print(intage);
      print(intempdur);
      print(intinr);
      print(response.statusCode);
      throw 'Problem with the post request';
    }

    //await apiRequest("192.168.0.105:8000/credit", data);
  }

  Future apiLoancall() async {
    //   https://62408d4b4c7e.ngrok.io
    intloanamt = int.parse(loanamt);
    temp1 = lcloanDurationController.text;
    intloandur = int.parse(loandur);

    var uri = Uri.https("62408d4b4c7e.ngrok.io", "/loan");
    print(uri);
    //var url = "192.168.0.105:8000/credit";
    // Map data = {
    //   'Account Balance': [intaccbal],
    //   'Duration of Credit (month)': 0,
    //   'Payment Status of Previous Credit': 0,
    //   'Credit Amount': 1049,
    //   'Value Savings/Stocks': intinr,
    //   'Length of current employment': intempdur,
    //   'Age (years)': intage,
    //   'Concurrent Credits': 3,
    //   'Type of apartment': intappstatus,
    //   'No of Credits at this Bank': intccwus,
    //   'Occupation': intaocc,
    //   'No of dependents': intdep
    // };
    http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'Gender': intgen,
          'Married': intmarr,
          'Dependents': intdep,
          'Education': intedulevel,
          'Self_Employed': intselfemp,
          'ApplicantIncome': intinc,
          'CoapplicantIncome': intcoinc,
          'LoanAmount': intloanamt,
          'Loan_Amount_Term': intloandur,
          'Creditability': credit,
          'Property_Area': 2,
        }));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson.toString() == "{prediction: [1]}") {
        print("loan accepted");
        loanStatusvar = "APPROVED!";
        User user = _auth.currentUser;
        // String userId = (FirebaseAuth.instance.currentUser).uid;
        await _firestore.collection("users").doc(user.uid).update({
          'LoanInt': 1,
        });
        // loanint = 1;
      }
      if (responseJson.toString() == "{prediction: [0]}") {
        print("loan rejected");
        loanStatusvar = "REJECTED :(";
        User user = _auth.currentUser;
        // String userId = (FirebaseAuth.instance.currentUser).uid;
        await _firestore.collection("users").doc(user.uid).update({
          'LoanInt': 0,
        });
      }
      User user = _auth.currentUser;
      // String userId = (FirebaseAuth.instance.currentUser).uid;
      await _firestore.collection("users").doc(user.uid).update({
        'Loan Amount': lcloanAmtController.text,
        'Loan Duration': lcloanDurationController.text,
        'Loan Status': loanStatusvar,
        'Has applied': 1,
      });

      print("success");
    } else {
      print(intgen);
      print(intmarr);
      print(intdep);
      print(intedulevel);
      print(intselfemp);
      print(intinc);
      print(intcoinc);
      print(intloanamt);
      print(intloandur);
      print(credit);
      print(response.statusCode);
      throw 'Problem with the post request';
    }

    //await apiRequest("192.168.0.105:8000/credit", data);
  }

  // Future<String> apiRequest(url, Map jsonMap) async {
  //   http.Response response = await http.post(url);flut
  //   if (response.statusCode == 200) {
  //     print("success");
  //   } else {
  //     print(response.statusCode);
  //     throw 'Problem with the get request';
  //   }

  // Future<String> apiRequest(var url, Map jsonMap) async {
  //   url = Uri();
  //   http.Response response = await http.post(url);
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body));
  //     return (json.decode(response.body));

  //     print(response);
  //   } else {
  //     print(response.statusCode);
  //     throw 'Problem with the get request';
  //   }c
  // }
}
