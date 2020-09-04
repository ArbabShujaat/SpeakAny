import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:speakAny/constants/constants.dart';
import 'package:speakAny/ui/Screens/AudioPlayers.dart';
import 'package:speakAny/ui/Screens/signin.dart';
import 'package:speakAny/ui/Screens/signup.dart';
import 'package:speakAny/ui/Screens/splashscreen.dart';
import 'package:speakAny/ui/Screens/dashBoardScreen.dart';
import 'package:speakAny/ui/Screens/teachers_screen.dart';
import 'package:speakAny/ui/Screens/welcomeScreen.dart';
import 'package:speakAny/ui/widgets/youtube_playes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.blue, primarySwatch: Colors.blue),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        SIGN_IN: (BuildContext context) => SignInPage(),
        SIGN_UP: (BuildContext context) => SignUpScreen(),
        DASHBOARD_SCREEN: (BuildContext context) => DashboardScreen(),
        WELCOME_SCREEN: (BuildContext context) => WelcomeScreen(),
        YOUTUBE_PLAYER: (BuildContext context) => Youtube(
              url: "",
            ),
        TEACHERS_SCREEN: (BuildContext context) => TeachersScreen(),
        AUDIO_PLAYER: (BuildContext context) => AudioApp(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}
