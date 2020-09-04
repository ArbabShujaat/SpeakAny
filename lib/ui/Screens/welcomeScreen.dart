import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:speakAny/constants/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              color: Colors.grey[100],
              height: deviceHeight,
              width: deviceWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: deviceHeight / 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/siginlogo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                    child: Text(
                      "Join SpeakAny",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Text(
                      '''Create an accout and learn new languages easily on SpeakAny platform.''',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ButtonTheme(
                        height: 40,
                        minWidth: deviceWidth - 20,
                        child: RaisedButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 4, 8),
                                  child: Icon(
                                    AntDesign.apple1,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Continue with Apple",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {})),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: ButtonTheme(
                        minWidth: deviceWidth - 20,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Continue with Facebook",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {})),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: ButtonTheme(
                        minWidth: deviceWidth - 20,
                        child: RaisedButton(
                            color: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Continue with Google",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {})),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: ButtonTheme(
                        minWidth: deviceWidth - 20,
                        child: RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Sign Up with Email",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, SIGN_UP);
                            })),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "By Joining, you agree to Our ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Terms of Service",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SIGN_IN);
                    },
                    onLongPress: () {
                      Navigator.pushNamed(context, SIGN_IN);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Sign In ",
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
