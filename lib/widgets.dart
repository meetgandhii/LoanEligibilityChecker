import 'package:flutter/material.dart';
import 'ContactUs.dart';
import 'LoanChecker.dart';
import 'MyProfile.dart';


class DrawerLoan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('My Profile'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyProfile()));
            },
          ),
          ListTile(
            title: Text('Loan Checker'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoanChecker()));
            },
          ),
          ListTile(
            title: Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app
              // ...

              // Then close the drawer
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ContactUs()));
              
            },
          ),
        ],
      ),
    );
  }
}
