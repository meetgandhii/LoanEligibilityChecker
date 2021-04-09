import 'package:flutter/material.dart';
import 'widgets.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Startbar(
          appbartext: 'My Profile',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 60.0),
                child: Image.asset(
                  'assets/images/Meet_Temp_pfp.png',
                  width: 150,
                ),
              ),
              Details(
                name: 'Name: ' + 'Meet Gandhi',
                size: 25.0,
                align: Alignment.topLeft,
              ),
              Details(
                name: 'Email Id: ' + 'meetgandhi412@gmail.com',
                size: 15.5,
                align: Alignment.topLeft,
              ),
              Details(
                name: 'Loan Status: ' + 'No Loans applied for',
                size: 17.0,
                align: Alignment.topLeft,
              ),
              Details(
                name: 'Income: ' + '60,00,000 inr',
                size: 20.0,
                align: Alignment.topLeft,
              ),
              Details(
                name: 'Age: ' + '40',
                size: 25.0,
                align: Alignment.topLeft,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
