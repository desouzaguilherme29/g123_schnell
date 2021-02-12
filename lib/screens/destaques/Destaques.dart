import 'package:flutter/material.dart';
import 'package:g123_schnell/screens/destaques/PesquisaContato.dart';
import 'package:g123_schnell/screens/destaques/form_gridview_add_recentementes.dart';
import 'package:g123_schnell/screens/destaques/form_gridview_patrocinados_recente.dart';
import 'package:story_viewer/models/story_item.dart';
import 'package:story_viewer/models/user.dart';
import 'package:story_viewer/viewer.dart';

class Destaques extends StatefulWidget {
  @override
  _DestaquesState createState() => _DestaquesState();
}

class _DestaquesState extends State<Destaques> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
      body:Column(
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
                      fontFamily: "LatoBlackItalic"
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
                  _StoryView(),

                  FormViewPatrocinadosRecentemente(),
                  FormViewAddRecentemente()
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget _StoryView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,0,0,0),
      child: StoryViewer(
        padding: EdgeInsets.all(8),
        backgroundColor: Colors.white,
        ratio: StoryRatio.r16_9,
        loop: true,
        hasReply: false,
        mediaFit: BoxFit.fill,
        stories: [
          StoryItemModel(
              imageProvider: NetworkImage(
                  "https://g123.com.br/publicidade/centro/casaril.jpg")),
          StoryItemModel(
              imageProvider: NetworkImage(
                  "https://g123.com.br/publicidade/centro/centro2.gif"))
        ],
        userModel: UserModel(
          username: "Guia Schnell",
          profilePicture: Image.asset("imagens/logoempresaicone.png").image,
        ),
      )
    );
  }
}
