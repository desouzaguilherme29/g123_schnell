import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:g123_schnell/model/url_service.dart';
import 'package:g123_schnell/screens/ClienteDetalhe.dart';
import 'package:g123_schnell/templates/loading.dart';
import 'package:g123_schnell/templates/template_error.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormViewAddRecentemente extends StatefulWidget {
  @override
  _FormViewAddRecentementeState createState() =>
      _FormViewAddRecentementeState();
}

Future _getClientes() async {
  http.Response response;

  response = await http.get(getURLAdicionadosRecentes(filtro: ""));

  return json.decode(response.body);
}

class _FormViewAddRecentementeState extends State<FormViewAddRecentemente> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getClientes(),
      // ignore: missing_return
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loading();
            break;
          default:
            if (snapshot.hasError) {
              return ErroCarregarDados();
            } else {
              return Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 285,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Adicionados recentemente",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w700, fontFamily: "LatoBlackItalic"),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(5),
                          height: 160,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                //projectSnap.data[index][""]
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  width: 160.0,
                                  child:
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ClienteDetalhe()));
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(bottom: 6),
                                                  child: Center(
                                                      child: Text(
                                                          snapshot.data[index]
                                                          ["nomedono"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontFamily: "LatoBlackItalic"
                                                          ),
                                                          maxLines: 3,
                                                          textAlign:
                                                          TextAlign.center)
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            snapshot.data[index]["nrofone_formatado"]
                                                .toString(),
                                            style: TextStyle(
                                                color:
                                                Theme.of(context).primaryColor,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "LatoBlackItalic"
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            snapshot.data[index]["cidade"]
                                                .toString() + "-" + snapshot.data[index]["uf"]
                                                .toString(),

                                            style: TextStyle(
                                                color:
                                                Theme.of(context).primaryColor,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "LatoBlackItalic"
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            formatDate(
                                                DateTime.parse(snapshot
                                                    .data[index]["data_cadastro"]
                                                    .toString()),
                                                [
                                                  dd,
                                                  '/',
                                                  mm,
                                                  '/',
                                                  yyyy,
                                                  ' ',
                                                  HH,
                                                  ':',
                                                  nn
                                                ]),
                                            style: TextStyle(
                                                color:
                                                Theme.of(context).primaryColor,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "LatoBlackItalic"
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(
                                            2.0,
                                            2.0,
                                          ),
                                        )
                                      ]),
                                );
                              })),
                    ],
                  )
                ],
              );
            }
        }
      },
    );
  }
}
