import 'package:LoanEligibilityChecker/AuthenticationService.dart';
import 'package:LoanEligibilityChecker/SignUp.dart';
import 'package:LoanEligibilityChecker/backgroundandimg.dart';
import 'package:LoanEligibilityChecker/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'const.dart';
import 'backgroundandimg.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool validEmail;
  // String emailValidstring(String value) {
  //   Pattern pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value))
  //     return 'Enter Valid Email';
  //   // return validEmail = valid;
  //   else
  //     return null;
  // }

  // bool emailValidbool(String value) {
  //   Pattern pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value))
  //     return validEmail = false;
  //   // return validEmail = valid;
  //   else
  //     return validEmail = true;
  // }

  final emailvalid = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    PatternValidator(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        errorText: 'enter valid email')
  ]);
  final passwordvalid = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    PatternValidator(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&])[A-Za-z\d@$#!%*?&]{8,}$",
        errorText:
            'Enter the password you used on signup')
  ]);
  final TextEditingController emailController = TextEditingController();
bool showpass = false;
  bool passwordObscure = true;

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Backgroundandimg(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 140.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: loginpageTextColor,
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9@_/./+/-]"),
                      ),
                    ],
                    keyboardType: TextInputType.emailAddress,
                    validator: emailvalid,
                    //                 validator: (var value) {
                    // return (value != null && value.contains('0')) ? 'Do not use the @ char.' : null;},
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email Id",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9@_/./+/()#\-/@/!/%/*/?/&\$]"),
                      ),
                    ],
                    validator: passwordvalid,
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: passwordObscure,
                  ),
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('show password'),
                  value: showpass,
                  onChanged: (ne) {
                    setState(() {
                      showpass = ne;
                      if (ne == true)
                        passwordObscure = false;
                      else
                        passwordObscure = true;
                    });
                  }),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: FlatButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                    },
                    child: Text(
                      "New User? Sign in",
                      //send otp here
                      style: TextStyle(fontSize: 12, color: loginpageTextColor),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: RaisedButton(
                    onPressed: () async {
                      // showAlertDialog(context);
                      context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                      // Navigator.pop(context);
                      // _onLoading();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MyProfile()),
                      // );
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
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }
}
