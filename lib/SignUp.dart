import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:LoanEligibilityChecker/backgroundandimg.dart';
import 'package:LoanEligibilityChecker/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AuthenticationService.dart';
import 'const.dart';
import 'MyProfile.dart';
import 'backgroundandimg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
    final nameValid = MultiValidator([
      RequiredValidator(errorText: 'Name is required'),
      PatternValidator((r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'), errorText: 'enter valid name')
    ]);
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
        errorText: 'Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character')
  ]);
  //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
  List<String> _optionsGender = [
    'Male',
    'Female',
    'Other',
    'Rather not specify'
  ];
  List<String> _optionsOccupation = [
    'Unemployed',
    'Unskilled Employee',
    'Skilled Employee',
    'Self Employed'
  ];
  List<String> _apartmentStatus = [
    'Rented Flat',
    'Own an apartment',
    'Free apartment',
    // 'Rather not specify'
  ]; // Option 2
  List<String> _optionsYesNo = [
    'Yes',
    'No',
  ]; //
  String _selectedoptionGender; // Option 2
  String _selectedoptionMarry; // Option 2
  String _selectedoptionSelfEmployed; // Option 2
  String _selectedoptionApartmentStatus; // Option 2
  String _selectedoptionOccupation; // Option 2

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool checkBox = false;
  bool passwordObscure = true;
  final _auth = FirebaseAuth.instance;
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 3), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  PickedFile _image;
  String _uploadedFileURL;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    // dynamic user = Provider.of<AuthenticationService>(context);
    Size size = MediaQuery.of(context).size;
    // return Scaffold(
    var body = Backgroundandimg(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: loginpageTextColor,
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              // DropDown(),
              SignUpWidget(
                regex: RegExp("[a-zA-Z]"),
                valid: nameValid,
                label: 'Name',
                hint: 'Meet / Any Name',
                bl: false,
                controllerVar: spnameController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'Age',
                hint: '19 / Any Number',
                bl: false,
                controllerVar: spageController,
              ),
              SizedBox(height: 10.0),
              Container(
                width: 1000,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.75,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
                child: DropdownButton(
                  hint: Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ), // Not necessary for Option 1
                  value: _selectedoptionGender,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedoptionGender = newValue;
                      print(_selectedoptionGender);
                    });
                  },
                  items: _optionsGender.map((option) {
                    return DropdownMenuItem(
                      child: new Text(option),
                      value: option,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10.0),
              // SignUpWidget(
              //   label: 'Gender',
              //   hint: 'Male / Female / Other',
              //   bl: false,
              //   controllerVar: spgenderController,
              // ),
              Container(
                width: 1000,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.75,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
                child: DropdownButton(
                  hint: Text(
                    'Are you married',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ), // Not necessary for Option 1
                  value: _selectedoptionMarry,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedoptionMarry = newValue;
                      print(_selectedoptionMarry);
                    });
                  },
                  items: _optionsYesNo.map((option) {
                    return DropdownMenuItem(
                      child: new Text(option),
                      value: option,
                    );
                  }).toList(),
                ),
              ),
              // SignUpWidget(
              //   label: 'Are you married',
              //   hint: 'Yes/No',
              //   bl: false,
              //   controllerVar: spmarryController,
              // ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'Number of Dependants',
                hint: '0/1/2/3/...',
                bl: false,
                controllerVar: spdependantsController,
              ),
              SignUpWidget(
                regex: RegExp("[a-zA-Z]"),
                label: 'Your Education',
                hint: 'UG/PG/HighSchool/School',
                bl: false,
                controllerVar: speducationController,
              ),
              SizedBox(height: 10.0),
              Container(
                width: 1000,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.75,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
                child: DropdownButton(
                  hint: Text(
                    'Are you self employed',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ), // Not necessary for Option 1
                  value: _selectedoptionSelfEmployed,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedoptionSelfEmployed = newValue;
                      print(_selectedoptionSelfEmployed);
                    });
                  },
                  items: _optionsYesNo.map((option) {
                    return DropdownMenuItem(
                      child: new Text(option),
                      value: option,
                    );
                  }).toList(),
                ),
              ),
              // SignUpWidget(
              //   label: 'Are you self employed?',
              //   hint: 'Yes/No',
              //   bl: false,
              //   controllerVar: spselfemployController,
              // ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'Your Income',
                hint: 'In Numeric Value Only',
                bl: false,
                controllerVar: spyourincomeController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'Co-Applicant\'s Income',
                hint: 'In Numeric Value Only',
                bl: false,
                controllerVar: spcoincomeController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'Property Area',
                hint: 'Enter the number of square feet',
                bl: false,
                controllerVar: sppropertyareaController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'Account Balance',
                bl: false,
                hint: 'Numeric Value Only',
                controllerVar: spaccbalController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'Savings Amount',
                hint: 'Numeric Value Only',
                bl: false,
                controllerVar: spsavingsController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'How long have you been employed?',
                hint: 'In years',
                bl: false,
                controllerVar: spemploydurationController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'How many credit cards do you have with our bank?',
                hint: 'Numeric Value only',
                bl: false,
                controllerVar: spccwusController,
              ),
              SignUpWidget(
                regex: RegExp("[0-9]"),
                label: 'How many credit cards do you have with other banks?',
                hint: 'Numeric Value only',
                bl: false,
                controllerVar: spccwothersController,
              ),
              SizedBox(height: 10.0),
              Container(
                width: 1000,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.75,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
                child: DropdownButton(
                  hint: Text(
                    'What is your occupation status',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ), // Not necessary for Option 1
                  value: _selectedoptionOccupation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedoptionOccupation = newValue;
                      print(_selectedoptionOccupation);
                    });
                  },
                  items: _optionsOccupation.map((option) {
                    return DropdownMenuItem(
                      child: new Text(option),
                      value: option,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10.0),
              // SignUpWidget(
              //   label: 'Own your apartment/Pay rent/Live for free',
              //   hint: 'Own/Rent/Free',
              //   bl: false,
              //   controllerVar: spaptstatusController,
              // ),
              // SignUpWidget(
              //   label: 'Occupation',
              //   hint: 'unemployed/unskilled/skilled/self employed',
              //   bl: false,
              //   controllerVar: spoccupationController,
              // ),
              Container(
                width: 1000,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.75,
                      color: Color(0xFF323232),
                    ),
                  ),
                ),
                child: DropdownButton(
                  hint: Text(
                    'What is your apartment status',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ), // Not necessary for Option 1
                  value: _selectedoptionApartmentStatus,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedoptionApartmentStatus = newValue;
                      print(_selectedoptionApartmentStatus);
                    });
                  },
                  items: _apartmentStatus.map((option) {
                    return DropdownMenuItem(
                      child: new Text(option),
                      value: option,
                    );
                  }).toList(),
                ),
              ),
              SignUpWidget(
                regex: RegExp("[a-zA-Z0-9@_/./+/-]"),
                valid: emailvalid,
                label: 'Email Id',
                hint: 'test@gmail.com',
                bl: false,
                controllerVar: spemailController,
              ),
              SignUpWidget(
                valid: passwordvalid,
                 regex: RegExp("[a-zA-Z0-9@_/./+/()#\-/@/!/%/*/?/&\$]"),
                label: 'Password',
                hint: 'password',
                bl: passwordObscure,
                controllerVar: sppasswordController,
              ),
              CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('show password'),
                  value: checkBox,
                  onChanged: (ne) {
                    setState(() {
                      checkBox = ne;
                      if (ne == true)
                        passwordObscure = false;
                      else
                        passwordObscure = true;
                    });
                  }),
              Column(
                children: [
                  Text('Selected Image'),
                  _image != null
                      ? Image.asset(
                          _image.path,
                          height: 150,
                        )
                      : Container(height: 150),
                  _image == null
                      ? RaisedButton(
                          child: Text('Choose File'),
                          onPressed: chooseFile,
                          color: Colors.cyan,
                        )
                      : Container(),
                  _image != null
                      ? RaisedButton(
                          child: Text('Upload File'),
                          onPressed: uploadFile,
                          color: Colors.cyan,
                        )
                      : Container(),
                  _image != null
                      ? RaisedButton(
                          child: Text('Clear Selection'),
                          onPressed: clearSelection,
                        )
                      : Container(),
                  Text('Uploaded Image'),
                  _uploadedFileURL != null
                      ? Image.network(
                          _uploadedFileURL,
                          height: 150,
                        )
                      : Container(),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                    context.read<AuthenticationService>().signUp(
                          email: spemailController.text,
                          password: sppasswordController.text,
                        );
                        // print(_selectedoptionMarry + " " + _selectedoptionGender, );
                    User user = _auth.currentUser;
                    String userId = (FirebaseAuth.instance.currentUser).uid;
                    await _firestore.collection("users").doc(user.uid).set({
                      'Name': spnameController.text,
                      'Email Id': spemailController.text,
                      'Age': spageController.text,
                      'Gender': _selectedoptionGender,
                      'Marriage Status': _selectedoptionMarry,
                      'Number of Dependant': spdependantsController.text,
                      'Education Level': speducationController.text,
                      'Are they self employed': _selectedoptionSelfEmployed,
                      'Applicant\s income': spyourincomeController.text,
                      'Co-applicant\s income': spcoincomeController.text,
                      'Property Area': sppropertyareaController.text,
                      'Account Balance': spaccbalController.text,
                      'Savings in INR': spsavingsController.text,
                      'Currently employed from how long':
                          spemploydurationController.text,
                      'Number of credit cards at this bank':
                          spccwusController.text,
                      'Number of credit cards with other banks':
                          spccwothersController.text,
                      'Apartment Status': _selectedoptionApartmentStatus,
                      'Occupation': _selectedoptionOccupation,
                      'UID': userId,
                      'Loan Status': 'No Loans Applied For',
                      'Pfp': _uploadedFileURL,
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile()),
                    );
                    _onLoading();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: boxDesign(),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "SignUp",
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
      // ),
    );
    var bodyProgress = new Container(
      child: new Stack(
        children: <Widget>[
          body,
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: new BorderRadius.circular(10.0)),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "loading.. wait...",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
      body: new Container(child: _loading ? bodyProgress : body),
    );
  }

  Future chooseFile() async {
    await picker.getImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    FirebaseStorage storageReference = FirebaseStorage.instance;
    Reference ref =
        storageReference.ref().child('profiles/${Path.basename(_image.path)}}');
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final File file = File(pickedFile.path);
    UploadTask uploadTask = ref.putFile(file);
    // await uploadTask;
    uploadTask.whenComplete(() async {
      print('File Uploaded');
      ref.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
        });
        // print(fileURL);
      });
    });
  }

  void clearSelection() {
    setState(() {
      _image = null;
      _uploadedFileURL = null;
    });
  }
}
