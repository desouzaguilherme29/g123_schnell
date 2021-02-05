import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

    response = await http.get(getURLDetalhesCliente("11976640765"));

    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
        body:
            /*Stack(
      children: <Widget>[
        FutureBuilder(
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
      ],
    )*/
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.nomeCliente,
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
            Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                height: 200,
                child: Row(
                  //Stretches to vertically fill its parent container
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        height: 200,
                        width: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://g123.com.br/publicidade/17/46988057882/gifs/mestrecaseiro.png"),
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
                                  child: Container(
                                    height: 70,
                                    child: Text(
                                      "Mestre Caseiro Restaurante e Marmitex",
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    height: 30,
                                    child: Text(
                                      "Francisco Beltrão - PR",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    height: 30.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        fazerLigacao("(46) 98805-7882");
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
                                              maxWidth: 100.0, minHeight: 50.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Ligar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SocialMediaButton.instagram(
                                        url: null,
                                        color: Colors.pinkAccent,
                                      ),
                                      SocialMediaButton.facebook(
                                        url: null,
                                        color: Colors.blue,
                                      ),
                                      SocialMediaButton.whatsapp(
                                        url: null,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))),
                  ],
                )),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  child: Text(
                    "Dica Schnell",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                "Mestre Caseiro Restaurante e Marmitex oferece: Marmitex; Buffet por kg e livre; Entregas de marmitas. De segunda-feira a sexta-feira das 11:00 às 13:00. Em frente à UNIPAR!",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ),
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

  fazerLigacao(String telefone) async {
    var url = "tel:" + telefone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
