import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakAny/constants/constants.dart';
import 'package:speakAny/ui/widgets/dash_board_widgets.dart';
import 'package:speakAny/ui/widgets/responsive_ui.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

UserData user;

class _DashboardScreenState extends State<DashboardScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  int _selectedIndex = 0;
  bool _isLoadingLogin = true;

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) async {
      if (pref.containsKey('userData')) {
        final extractedUserData = await json.decode(pref.getString('userData'))
            as Map<String, Object>;
        String shopUserEmail = extractedUserData['userEmail'];
        String userUid = extractedUserData['userUid'];
        await Firestore.instance
            .collection("Users")
            .where("useruid", isEqualTo: userUid)
            .getDocuments()
            .then((value) => {
                  user = UserData(
                      image: value.documents[0]['userimage'],
                      language: value.documents[0]['language'],
                      name: value.documents[0]['firstname'] +
                          " " +
                          value.documents[0]['lastname'])
                })
            .then((value) => {
                  setState(() {
                    _isLoadingLogin = false;
                  })
                });
      }
      if (!pref.containsKey('userData')) {
        setState(() {
          _isLoadingLogin = false;
        });
      }
    });

    super.initState();
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
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: 1.2 * _height,
              width: _width,
              margin: EdgeInsets.only(bottom: 5),
              child: _isLoadingLogin
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      child: Stack(
                        children: <Widget>[
                          Opacity(
                              opacity: 0.88, child: CustomAppBarDashBoard()),
                          Positioned(
                            top: _height / 3.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          videosScroll(context, "Intoduction",
                                              "https://youtu.be/6TqSsWTj8ho"),
                                          videosScroll(context, "How to Use",
                                              "https://youtu.be/58y0AN2k4xc"),
                                          videosScroll(context, "Features",
                                              "https://youtu.be/YLtFGWVWiGo"),
                                        ],
                                      )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Top Teachers",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Spacer(),
                                        Text(
                                          "see all",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width: _width,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          teachersAvatar(
                                              context, "assets/images/t1.jpeg"),
                                          teachersAvatar(
                                              context, "assets/images/t2.jpeg"),
                                          teachersAvatar(
                                              context, "assets/images/t3.jpeg"),
                                          teachersAvatar(
                                              context, "assets/images/t4.jpeg"),
                                          teachersAvatar(
                                              context, "assets/images/t5.jpeg"),
                                          teachersAvatar(
                                              context, "assets/images/t6.jpeg"),
                                          teachersAvatar(
                                              context, "assets/images/t7.jpeg"),
                                        ],
                                      )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Popular Languages",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // Spacer(),
                                        // Text(
                                        //   "see all",
                                        //   style: TextStyle(fontSize: 12),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      width: _width,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: GridView(
                                          children: <Widget>[
                                            languageScroll(
                                                "assets/images/US.png",
                                                "ENGLISH"),
                                            languageScroll(
                                                "assets/images/pak.png",
                                                "URDU"),
                                            languageScroll(
                                                "assets/images/canada.png",
                                                "Fench"),
                                            languageScroll(
                                                "assets/images/china.png",
                                                "Chineese"),
                                            languageScroll(
                                                "assets/images/iran.png",
                                                "URDU"),
                                            languageScroll(
                                                "assets/images/ind.png",
                                                "Persian"),
                                          ],
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 1.3,
                                                  crossAxisCount: 3),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          )

                          //signInTextRow(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class CustomAppBarDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            height: height / 3,
            width: width,
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     colors: [Hexcolor("#33FFFC"), Hexcolor("#0645DF")]),
              image: DecorationImage(
                image: AssetImage("assets/images/US.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: height / 3,
            width: width,
            color: Colors.black45.withOpacity(0.5),
            padding: EdgeInsets.only(left: 15, top: 25),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 10, 0),
                      child: CircleAvatar(
                          minRadius: 30,
                          backgroundImage: AssetImage("assets/images/t2.jpeg")),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 10, 0),
                      child: IconButton(
                          icon: Icon(Icons.notifications, color: Colors.white),
                          onPressed: () async {
                            auth.signOut();
                            var prefs = await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.pushReplacementNamed(context, SIGN_IN);
                          }),
                    ),
                  ],
                ),
                SizedBox(height: height / 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Chip(
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Search a Language...",
                                style: TextStyle(color: Colors.blue[800]),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(Icons.search, color: Colors.blue[800]),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserData {
  final String name;
  final String image;
  final String language;

  UserData(
      {@required this.name, @required this.image, @required this.language});
}
