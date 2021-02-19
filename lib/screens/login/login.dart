import 'package:auth_buttons/auth_buttons.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g123_schnell/FuncoesGerais/GlobalStatics.dart';
import 'package:g123_schnell/screens/HomePage.dart';

import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  String appName = 'Auth Buttons Example';
  bool darkMode = true;
  AuthButtonStyle authButtonStyle = AuthButtonStyle.icon;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 60),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.1,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(197, 246, 248, 1.0),
                      Color.fromRGBO(2, 30, 105, 1.0)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('imagens/loginimagem.png',height: 220,),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 32,
                          right: 32
                      ),
                      child: Text('Entrar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(

              height: MediaQuery.of(context).size.height/1.91,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  GoogleAuthButton(
                    onPressed: _signInWithGoogle,
                    text: "Entre com o Google",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AppleAuthButton(
                    onPressed: () {},
                    text: "Entre com a Apple",
                  ),
                  Spacer(),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> _signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final GoogleAuthCredential googleAuthCredential =
            GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
      }

      final user = userCredential.user;

      GlobalStatics.displayName =  user.displayName;
      GlobalStatics.email =  user.email;
      GlobalStatics.photoURL =  user.photoURL;

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print('Failed to sign in with Google: $e');
    }
  }
}
