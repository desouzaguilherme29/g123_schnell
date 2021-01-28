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
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                expandedHeight: 250.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.fromLTRB(5, 0, 0, 20),
                    collapseMode: CollapseMode.pin,
                    centerTitle: false,
                    background: _StoryView(),
                    title: Container(
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        color: Color.fromRGBO(2, 30, 105, 0.8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          "Bem Vindo, Guilherme Antonio",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )),
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              PesquisaContato(),
              FormViewPatrocinadosRecentemente(),
              FormViewAddRecentemente()
            ],
          ),
        ),

    );
  }

  Widget _StoryView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,24,0,0),
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
