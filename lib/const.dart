import 'package:flutter/material.dart'; 

const appBarandButtonColor = Color(0xFF1831D5);
const bgImg = AssetImage("asset/images/appBg2.png");
const loanImage = 'asset/images/appimageLoan.jpeg';
const profileImage = AssetImage('asset/images/Meet_Temp_pfp.png');
const shadowColor = Color(0xFF0000FF);
const textColor = Color(0xFFE6E6FF);

//signin
TextEditingController emailController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String dob;
String dt, mnth, yr;
String dobText = 'Click here to select DOB';

