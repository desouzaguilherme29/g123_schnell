import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:g123_schnell/screens/HomePage.dart';
import 'package:g123_schnell/screens/destaques/PesquisaContato.dart';
import 'package:g123_schnell/screens/destaques/form_gridview_add_recentementes.dart';
import 'package:g123_schnell/screens/destaques/form_gridview_patrocinados_recente.dart';

class TelefonesUteis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Bem vindo, Guilherme Antonio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,6,0,0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  PesquisaContato(),
                  FormViewPatrocinadosRecentemente(),
                  FormViewAddRecentemente()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}