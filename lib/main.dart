import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:g123_schnell/FuncoesGerais/GlobalStatics.dart';
import 'package:g123_schnell/firebase.dart';
import 'package:g123_schnell/screens/HomePage.dart';
import 'package:g123_schnell/screens/login/login.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guia Schnell',
        theme: ThemeData(
            primaryColor: Color.fromRGBO(2, 30, 105, 1.0),
            accentColor: Color(0xff25D366)),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', ''),
        ],
        home: AnimatedSplashScreen.withScreenFunction(
          splash: "imagens/logoschnell.png",
          splashIconSize: 240,
          duration: 3000,
          screenFunction: () async {
            initFcm();
            if (_auth.currentUser != null) {
              GlobalStatics.displayName =  _auth.currentUser.displayName;
              GlobalStatics.email =  _auth.currentUser.email;
              GlobalStatics.photoURL =  _auth.currentUser.photoURL;

              return HomePage();
            } else {
              return Login();
            }
          },
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
        ));
  }
}
