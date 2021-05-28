import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets.dart';

class WhyRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String userId = (FirebaseAuth.instance.currentUser).uid;

    return FutureBuilder(
      future: _firestore.collection('users').doc(userId).get(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var userdata = snapshot.data.data();
        String name = userdata['Name'];
        String emailid = userdata['Email Id'];
        String accbal = userdata['Account Balance'];
        String inc = userdata['Applicants income'];
        String age = userdata['Age'];
        String appstatus = userdata['Apartment Status'];
        String selfemp = userdata['Are they self employed'];
        String coinc = userdata['Co-applicants income'];
        String empdur = userdata['Currently employed from how long'];
        String edulevel = userdata['Education Level'];
        String gender = userdata['Gender'];
        String marry = userdata['Marriage Status'];
        String dependants = userdata['Number of Dependant'];
        String ccwus = userdata['Number of credit cards at this bank'];
        String ccwothers = userdata['Number of credit cards with other banks'];
        String occupation = userdata['Occupation'];
        String proparea = userdata['Property Area'];
        String inr = userdata['Savings in INR'];
        String pfp = userdata['Pfp'];
        String loanAmt = userdata['Loan Amount'];
        const url =
            'https://www.bankbazaar.com/cic/how-credit-score-is-calculated.html';
        void _launchurl() async => await canLaunch(url)
            ? await launch(url)
            : throw 'Could not launch $url';
        // bool isEmpty;
        if (!snapshot.hasData || snapshot.data.data().isEmpty) {
          return Center(child: CircularProgressIndicator());
        } //CIRCULAR INDICATOR
        else {
          return Scaffold(
            body: Startbar(
              appbartext: 'Why your loan got rejected',
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          RejectText(
                            customBorder: Border.all(color: Colors.transparent),
                            textalignn: TextAlign.center,
                            text: 'Hello ' + name + '!',
                            textstyle: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              border: Border.all(
                                color: Colors.blue[900],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: RejectText(
                                textalignn: TextAlign.center,
                                pad: EdgeInsets.all(10),
                                customBorder:
                                    Border.all(color: Colors.transparent),
                                textstyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                                text:
                                    'We are here to let you know how to improve your chances of getting approved.'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              border: Border.all(
                                color: Colors.blue[900],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: RejectText(
                                textstyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                                text: 'Lets first get started with your loan amount. \nYou reqested a loan of ' +
                                    '\'₹' +
                                    loanAmt +
                                    '\'' +
                                    ' from our bank and you currently earn ₹' +
                                    inc +
                                    ' and have a total of ₹' +
                                    accbal +
                                    ' in your bank account'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              border: Border.all(
                                color: Colors.blue[900],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: RejectText(
                              textstyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                              text:
                                  '\nIn order to get this loan approved you need to have either a stronger source of income or depend upon multiple sources of income and have some collateral(account balance) as an insurance that you\'ll be able to repay the loan back.\n',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              border: Border.all(
                                color: Colors.blue[900],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: RejectText(
                                textstyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                                text:
                                    'Based on the data you entered about yourself, you have a bad credit score. \n\n It largely depends upon your sources of income and account balance along with timely repayment of the loans. For more information you can visit our site '),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            color: Colors.black38.withOpacity(
                                0.00000001), //set this opacity as per your requirement
                            onPressed: _launchurl,
                            child: Text('by clicking here'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigation(),
          );
        }
      },
    );
  }
}

class RejectText extends StatelessWidget {
  const RejectText({
    Key key,
    @required this.text,
    this.textstyle,
    this.textalignn,
    this.customBorder,
    this.pad,
  }) : super(key: key);

  final String text;
  final textstyle;
  final textalignn;
  final customBorder;
  final pad;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: pad,
      decoration: BoxDecoration(
        border: customBorder,
      ),
      child: Text(text, textAlign: textalignn, style: textstyle),
    );
  }
}
