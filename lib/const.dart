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

//signin
TextEditingController emailController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String dob;
String dt, mnth, yr;
String dobText = 'Click here to select DOB';


TextEditingController spnameController = TextEditingController();
TextEditingController spageController = TextEditingController();
TextEditingController spgenderController = TextEditingController();
TextEditingController spmarryController = TextEditingController();
TextEditingController spdependantsController = TextEditingController();
TextEditingController speducationController = TextEditingController();
TextEditingController spselfemployController = TextEditingController();
TextEditingController spyourincomeController = TextEditingController();
TextEditingController spcoincomeController = TextEditingController();
TextEditingController sppropertyareaController = TextEditingController();
TextEditingController spaccbalController = TextEditingController();
TextEditingController spsavingsController = TextEditingController();
TextEditingController spemploydurationController = TextEditingController();
TextEditingController spccwusController = TextEditingController(); //ccwus = credit cards with us
TextEditingController spccwothersController = TextEditingController(); // see upar and samaj jao khudse
TextEditingController spaptstatusController = TextEditingController();
TextEditingController spoccupationController = TextEditingController();
TextEditingController spemailController = TextEditingController();
TextEditingController sppasswordController = TextEditingController();
TextEditingController lcloanAmtController = TextEditingController();
TextEditingController lcloanDurationController = TextEditingController();