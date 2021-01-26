import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:g123_schnell/screens/HomePage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      home: SplashScreenView(
        home: HomePage(),
        duration: 3000,
        imageSize: 200,
        imageSrc: "imagens/iconesemfundo.png",
        text: "Guia Schnell",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
          fontSize: 30.0,
          color: Colors.white,
            fontFamily: "Lato"
        ),
        backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
      )
    );
  }
}
