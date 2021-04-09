import 'package:flutter/material.dart';
import 'widgets.dart';
import 'AboutUs.dart';
import 'ChatWithUs.dart';
import 'FAQs.dart';
import 'MyProfile.dart';
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
      body: Startbar(
        appbartext: 'Contact Us',
        child: Column(),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
