import 'package:flutter/material.dart';

const appBarandButtonColor = Color(0xFF1831D5);
const bgImg = AssetImage("asset/images/appBg2.png");
const loanImage = 'asset/images/appimageLoan.jpeg';
const profileImage = AssetImage('asset/images/Meet_Temp_pfp.png');
const shadowColor = Color(0xFF0000FF);
const textColor = Color(0xFFE6E6FF);
const loginpageTextColor = Color(0xFF2661FA);
// const IconData arrow_forward = IconData(0xe5af, fontFamily: 'MaterialIcons', matchTextDirection: true);
const darkblue = Color(0xFF180e58);
String loanStatus = "No Loans Currently";
//signin
TextEditingController emailController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String dob;
String dt, mnth, yr;
String dobText = 'Click here to select DOB';

BoxDecoration boxDesign() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(80),
      gradient: LinearGradient(colors: [
        Color.fromRGBO(13, 148, 251, 1),
        Color.fromRGBO(13, 148, 251, .6),
      ]));
}
