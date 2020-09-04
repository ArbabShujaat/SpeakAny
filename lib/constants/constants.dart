import 'package:firebase_auth/firebase_auth.dart';

String url;
final String SIGN_IN = 'signin';
final String SIGN_UP = 'signup';
final String SPLASH_SCREEN = 'splashscreen';
final String DASHBOARD_SCREEN = 'dasboard';
final String WELCOME_SCREEN = 'welcome';

final String YOUTUBE_PLAYER = 'youtubeplayer';
final String TEACHERS_SCREEN = 'teacherscreen';
final String AUDIO_PLAYER = 'audioplayer';

String userEmail = '';
String userUid = '';
final FirebaseAuth auth = FirebaseAuth.instance;
