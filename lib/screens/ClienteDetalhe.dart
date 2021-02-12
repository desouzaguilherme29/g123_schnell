import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g123_schnell/FuncoesGerais/funcoesGerais.dart';
import 'package:g123_schnell/model/url_service.dart';
import 'package:g123_schnell/templates/loading.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
import 'dart:async';
import 'dart:convert';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ClienteDetalhe extends StatefulWidget {
  @override
  _ClienteDetalheState createState() => _ClienteDetalheState();
  String nomeCliente;
  String fone;

  ClienteDetalhe({@required this.nomeCliente, @required this.fone});
}

class _ClienteDetalheState extends State<ClienteDetalhe> {
  @override
  Future _getClienteDetalhes() async {
    http.Response response;

    response = await http.get(getURLDetalhesCliente(widget.fone));

    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 45.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.white,),
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 30),
                      child:Text(
                        widget.nomeCliente,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: FutureBuilder(
                future: _getClienteDetalhes(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Loading();
                      break;
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _createGradeTable(context, snapshot);
                  }
                },
              ),
            ))
          ],
        ));
  }

  Widget _createGradeTable(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 0, 20),
                  child: Text(
                    "Dica Schnell",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: "LatoBold"),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            Divider(),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Text(
                    snapshot.data[index]["complemento"]
                        .toString()
                        .replaceAll("<br>", "\n")
                        .replaceAll("<b>", "")
                        .replaceAll("</b>", "\n")
                        .replaceAll("<font color=green>", "")
                        .replaceAll("</font>", ""),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "LatoBold",
                        color: Colors.black),
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                height: 230,
                child: Row(
                  //Stretches to vertically fill its parent container
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        height: 250,
                        width: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FadeInImage(
                                          height: 80,
                                          width: 158,
                                          fit: BoxFit.fill,
                                          image: snapshot.data[index]["arquivo"]
                                                      .toString() !=
                                                  ""
                                              ? NetworkImage(getUrlFotoPrincipal(
                                                  snapshot.data[index]["cidade_codigo"]
                                                      .toString(),
                                                  snapshot.data[index]["nrofone"]
                                                      .toString(),
                                                  snapshot.data[index]["arquivo"]
                                                      .toString()))
                                              : AssetImage(
                                                  'imagens/no-image-icon.png'),
                                          placeholder: AssetImage(
                                              'imagens/carrega_produtos.gif'))
                                      .image,
                                  fit: BoxFit.fill),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                ),
                              ]),
                          padding: EdgeInsets.all(0),
                        )),
                    Expanded(
                        child: Container(
                            height: 40,
                            width: 40,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      height: 50.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          fazerLigacao(snapshot.data[index]["nrofone"]);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80.0)),
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xff374ABE),
                                                  Color(0xff64B6FF)
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 150.0,
                                                minHeight: 50.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Ligar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                              fontFamily: "LatoBold"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Container(
                                    height: 30,
                                    child: Text(
                                      snapshot.data[index]["cidade"] + "-" +snapshot.data[index]["uf"],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data[index]["fone_whats"] != "" ? SocialMediaButton.whatsapp(
                                        size: 35,
                                        url: snapshot.data[index]["fone_whats"],
                                        color: Colors.green,
                                      ) : Container(),
                                      snapshot.data[index]["instagram"] != "" ? SocialMediaButton.instagram(
                                        size: 35,
                                        url: "https://" + snapshot.data[index]["instagram"],
                                        color: Colors.pinkAccent,
                                      ) : Container(),

                                    ],
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data[index]["face"].toString() != "" ? SocialMediaButton.facebook(
                                        size: 35,
                                        url: "https://" + snapshot.data[index]["face"].toString(),
                                        color: Colors.blueAccent,
                                      ) : Container(),
                                      snapshot.data[index]["twitter"].toString() != "" ? SocialMediaButton.twitter(
                                        size: 35,
                                        url: "https://" + snapshot.data[index]["twitter"].toString(),
                                        color: Colors.lightBlueAccent,
                                      ) : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ))),
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                height: 200,
                child: Row(
                  //Stretches to vertically fill its parent container
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            height: 40,
                            width: 40,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.local_library),
                                      Expanded(
                                        child: Container(
                                          height: 80,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Avenida Júlio Assis Cavalheiro, 2005",
                                                maxLines: 3,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              Text(
                                                "Bairro Industrial - 85601-274",
                                                maxLines: 3,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              Text(
                                                "Francisco Beltrão - PR",
                                                maxLines: 3,
                                                style: TextStyle(fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ))),
                    Container(
                        height: 150,
                        width: 130,
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () => MapsLauncher.launchQuery(
                              'Avenida Júlio Assis Cavalheiro, 2005 Bairro Industrial - 85601-274'),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/google-maps.png"),
                                    fit: BoxFit.fill),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(
                                      2.0,
                                      2.0,
                                    ),
                                  ),
                                ]),
                            padding: EdgeInsets.all(0),
                          ),
                        ))
                  ],
                )),
          ],
        );
      },
    );
  }
}
