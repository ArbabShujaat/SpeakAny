import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:speakAny/constants/constants.dart';
import 'package:speakAny/ui/widgets/dash_board_widgets.dart';
import 'package:speakAny/ui/widgets/responsive_ui.dart';

import 'dashBoardScreen.dart';

class TeachersScreen extends StatefulWidget {
  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    int _selectedIndex = 0;
    double _width = MediaQuery.of(context).size.width;
    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    bool _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    bool _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 20,
          color: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: _height,
              width: _width,
              margin: EdgeInsets.only(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      color: Colors.grey,
                      child: Opacity(
                          opacity: 0.88,
                          child: CustomAppBarTeacherDashBoard())),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 0, 8),
                        child: Text(
                          "English Language",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 0, 10),
                        child: Text(
                          "Lectures: 28",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: _height / 2,
                    width: _width,
                    child: ListView(
                      children: <Widget>[
                        playerListTiles(),
                        playerListTiles(),
                        playerListTiles(),
                      ],
                    ),
                  )

                  //signInTextRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget playerListTiles() {
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 8, 8),
          child: ListTile(
            trailing: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AUDIO_PLAYER);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      AntDesign.play,
                      color: Colors.blue,
                      size: 25,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "PLAY NOW",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
            title: Text(
              "Lecture 1 Engish Language",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Text("10 JAN"),
                  SizedBox(
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 6),
                    child: Icon(
                      AntDesign.clockcircleo,
                      size: 18,
                      color: Colors.blue,
                    ),
                  ),
                  Text("30 minutes")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomPlayer() {}
}

class CustomAppBarTeacherDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
              bottomRight: Radius.circular(80.0)),
          gradient: LinearGradient(
              colors: [Hexcolor("#33FFFC"), Hexcolor("#0645DF")]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            Container(
              height: height / 3.7,
              width: width,
              padding: EdgeInsets.only(left: 15, top: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80.0),
                    bottomRight: Radius.circular(80.0)),
                gradient: LinearGradient(
                    colors: [Hexcolor("#33FFFC"), Hexcolor("#0645DF")]),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 90,
                            width: 80,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(teacherimage),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.red)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Arbab Shujaat",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21),
                              ),
                              RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue)),
                                child: Row(
                                  children: <Widget>[
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Icon(
                                    //     Icons.done,
                                    //     color: Colors.red,
                                    //   ),
                                    // ),
                                    Text(
                                      "Enroll Now",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                onPressed: () {},
                              ),
                              Text(
                                "2k Students enrolled",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
