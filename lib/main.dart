import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:chatapp/authentication/SignupPage.dart';
import 'package:chatapp/authentication/auth.dart';
import 'package:chatapp/profile/Notification.dart';
import 'package:chatapp/profile/ProfileImage/findpplz.dart';
import 'package:chatapp/profile/Search_frendz.dart';
import 'package:chatapp/profile/likepplz/favpplz.dart';
import 'package:chatapp/profile/profileDetail.dart';
import 'package:chatapp/profile/profileInDetail/profilegallery.dart';
import 'package:chatapp/theme/themeProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'MyHomePage.dart';
import 'authentication/loginpage.dart';
import 'demo/splash_screen.dart';
import 'favList/favList.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(create: (context)=>ThemeProvider(),child: const MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatapp',
      theme: Provider.of<ThemeProvider>(context).themedata,
      home:  const AuthPage(),
    );
  }
}
