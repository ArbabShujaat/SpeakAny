import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakAny/constants/constants.dart';
import 'package:speakAny/ui/widgets/custom_shape.dart';
import 'package:speakAny/ui/widgets/customappbar.dart';
import 'package:speakAny/ui/widgets/responsive_ui.dart';
import 'package:speakAny/ui/widgets/textformfield.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool signupLoading = false;
  String imageUrl;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  Country _selected;
  bool imagecheck = false;
  File image;

  String filename;
  bool urlcheck = false;
  Language _selectedDialogLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('en');

  @override
  Future<void> didChangeDependencies() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.photos
    ].request();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),

                //acceptTermsTextRow(),
                SizedBox(
                  height: _height / 15,
                ),
                button(),
                // infoTextRow(),
                // socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Hexcolor("#33FFFC"), Hexcolor("#0645DF")],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Hexcolor("#33FFFC"), Hexcolor("#0645DF")],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: pic(),
        ),
//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
            countryTextFormField(),
            SizedBox(height: _height / 60.0),
            languageTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "First Name",
      textEditingController: firstnameController,
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Last Name",
      textEditingController: lastnameController,
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID",
      textEditingController: emailController,
    );
  }

  Widget countryTextFormField() {
    return new Center(
      child: CountryPicker(
        dense: false,
        showFlag: true, //displays flag, true by default
        showDialingCode: false, //displays dialing code, false by default
        showName: true, //displays country name, true by default
        showCurrency: false, //eg. 'British pound'
        showCurrencyISO: true, //eg. 'GBP'
        onChanged: (Country country) {
          setState(() {
            _selected = country;
          });
        },
        selectedCountry: _selected,
      ),
    );
  }

  Widget languageTextFormField() {
    return Center(
      child: Container(
        width: 180,
        child: GestureDetector(
            onTap: () {
              _openLanguagePickerDialog();
            },
            onLongPress: () {
              _openLanguagePickerDialog();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesome.language,
                  color: Colors.indigo,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_selectedDialogLanguage.name),
                ),
                Icon(Icons.arrow_drop_down)
              ],
            )),
      ),
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password",
      textEditingController: passwordController,
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.orange[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return signupLoading
        ? CircularProgressIndicator()
        : RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () async {
              if (imagecheck) {
                signUp();
              } else {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Colors.lightBlue,
                          )),
                      title: Text("Wait..."),
                      content: Text("Image Not Uploaded"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
              }
            },
            textColor: Colors.white,
            padding: EdgeInsets.all(0.0),
            child: Container(
              alignment: Alignment.center,
//        height: _height / 20,
              width: _large
                  ? _width / 4
                  : (_medium ? _width / 3.75 : _width / 3.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(
                  colors: <Color>[Hexcolor("#33FFFC"), Hexcolor("#1F67E6")],
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'SIGN UP',
                style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 12)),
              ),
            ),
          );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your language'),
                onValuePicked: (Language language) => setState(() {
                      _selectedDialogLanguage = language;
                      print(_selectedDialogLanguage.name);
                      print(_selectedDialogLanguage.isoCode);
                    }),
                itemBuilder: _buildDialogItem)),
      );
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/googlelogo.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(SIGN_IN);

              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }

  Future<void> signUp() async {
    setState(() {
      signupLoading = true;
    });
    try {
      final AuthResult user = (await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ));

      if (user != null) {
        var prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'userEmail': user.user.email,
            'userUid': user.user.uid,
            'password': passwordController.text,
          },
        );
        prefs.setString('userData', userData);
        userEmail = user.user.email;
        userUid = user.user.uid;

        await addUsertoFirebase(userUid);

        Navigator.pushReplacementNamed(context, DASHBOARD_SCREEN);
        setState(() {
          signupLoading = false;
        });

        // setState(() {
        //   _success = true;
        //   _userEmail = user.email;
        // }

      }
    } catch (signUpError) {
      setState(() {
        signupLoading = false;
      });

      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.lightBlue,
                    )),
                title: Text("Email already in use"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_WEAK_PASSWORD') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.lightBlue,
                    )),
                title: Text("Weak Password"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_INVALID_EMAIL') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.lightBlue,
                    )),
                title: Text("Invalid Email"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }
      }
    }
  }

  Future<void> addUsertoFirebase(String userUid) async {
    await Firestore.instance.collection("Users").add({
      'email': emailController.text,
      'firstname': firstnameController.text,
      'lastname': lastnameController.text,
      'language': _selectedDialogLanguage.name,
      'country': _selected.name,
      'useruid': userUid,
      'userimage': imageUrl,
    });
  }

  Widget pic() {
    return imagecheck
        ? CircleAvatar(maxRadius: 65, backgroundImage: FileImage(image))
        : GestureDetector(
            onTap: () async {
              image = await pickImage(context, ImageSource.gallery);

              if (image != null) {
                setState(() {
                  imagecheck = true;
                });

                final FirebaseStorage _storgae = FirebaseStorage(
                    storageBucket: 'gs://speakany-94f37.appspot.com/');
                StorageUploadTask uploadTask;
                String filePath = '${DateTime.now()}.png';
                uploadTask = _storgae.ref().child(filePath).putFile(image);
                uploadTask.onComplete.then((_) async {
                  print(1);
                  String url1 =
                      await uploadTask.lastSnapshot.ref.getDownloadURL();
                  image.delete().then((onValue) {
                    setState(() {
                      urlcheck = true;
                    });
                    print(2);
                  });
                  print(url1);

                  imageUrl = url1;
                  filename = filePath;
                  print(filename);
                });
              }
            },
            child: Icon(
              Icons.add_a_photo,
              size: _large ? 40 : (_medium ? 33 : 31),
              color: Hexcolor("#3FBCFF"),
            ));
  }

  Future<File> pickImage(BuildContext context, ImageSource source) async {
    File selected = await ImagePicker.pickImage(
      source: source,
      imageQuality: 20,
    );
    return selected;
  }
}
