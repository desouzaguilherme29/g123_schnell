import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g123_schnell/model/cidades.dart';
import 'package:g123_schnell/model/url_service.dart';
import 'package:g123_schnell/screens/ClienteDetalhe.dart';
import 'package:g123_schnell/templates/CabPages.dart';
import 'package:g123_schnell/templates/loading.dart';
import 'package:g123_schnell/templates/pesquise_vazia.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:filter_list/filter_list.dart';

class ResultadoPesquisa extends StatefulWidget {
  @override
  _ResultadoPesquisaState createState() => _ResultadoPesquisaState();
}

class _ResultadoPesquisaState extends State<ResultadoPesquisa> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _textEditingController = TextEditingController();

  List<String> countList = [];
  List<String> selectedCountList = [];

  Future _getCidades() async {
    http.Response response;

    response = await http.get(getURLCidades());

    var tagObjsJson = jsonDecode(response.body)['cidades'] as List;
    List<Cidade> cidades =
        tagObjsJson.map((tagJson) => Cidade.fromJson(tagJson)).toList();

    setState(() {
      countList = [
        for (int i = 0; i < cidades.length; i++) cidades[i].toString()
      ];
    });
  }

  void _openFilterDialog() async {
    await FilterListDialog.display(context,
        allTextList: countList,
        height: 480,
        borderRadius: 20,
        headlineText: "Selecione",
        selectedTextBackgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
        searchFieldHintText: "Pesquisar",
        allResetButonColor: Color.fromRGBO(2, 30, 105, 1.0),
        applyButonTextBackgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
        hideSelectedTextCount: true,
        selectedTextList: selectedCountList, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          selectedCountList = List.from(list);
        });
        Navigator.pop(context);
      }
    });
  }

  Future _getResultadoPesquisa() async {
    http.Response response;

    if (_textEditingController.text != "")
      response = await http
          .get(getURLResultadoPesquisa(filtro: _textEditingController.text));

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    _getCidades();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            key: _scaffoldkey,
            backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CabecalhoPaginas(
                  title: 'Resultado da Pesquisa',
                  tp_voltar: true,
                ),
                TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.grid_view),
                    ),
                    Tab(
                      icon: Icon(Icons.list_alt_sharp),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: _openFilterDialog,
                              child: Container(
                                margin: EdgeInsets.all(4),
                                width: MediaQuery.of(context).size.width * 0.98,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(2, 30, 105, 1.0),
                                    border: Border.all(
                                        color: Colors.white, width: 1.5),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: Text(
                                  "Cidades",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.3,
                                      fontFamily: "LatoBold"),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: _textEditingController,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                                hintText: "Pesquise aqui seu contato...",
                                hintStyle: TextStyle(fontFamily: "LatoBlack"),
                                suffixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0)))),
                            onSubmitted: (pesquisa) {
                              if (pesquisa.isNotEmpty || pesquisa != "")
                                setState(() {});
                              else
                                _scaffoldkey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                    'Campo pesquisa está vazio!',
                                    style: TextStyle(
                                        fontFamily: "LatoBlack", fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                            },
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: _getResultadoPesquisa(),
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Loading();
                                  break;
                                default:
                                  if (snapshot.hasError)
                                    return PesquisaVazia();
                                  else
                                    return _createGradeTable(context, snapshot);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  Widget _createGradeTable(BuildContext context, AsyncSnapshot snapshot) {
    return TabBarView(physics: NeverScrollableScrollPhysics(), children: [
      GridView.builder(
          padding: EdgeInsets.all(4.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.82,
          ),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.all(5),
                height: 250,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ClienteDetalhe(
                                      nomeCliente: snapshot
                                          .data[index]
                                      ["nomedono"]
                                          .toString(),
                                      fone: snapshot.data[index]
                                      ["nrofone"]
                                          .toString())));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: 160.0,
                      child: Column(
                        children: <Widget>[
                          FadeInImage(
                              height: 80,
                              width: 190,
                              fit: BoxFit.fill,
                              image: snapshot.data[index]
                              ["arquivo"]
                                  .toString() !=
                                  ""
                                  ? NetworkImage(
                                  getUrlFotoPrincipal(
                                      snapshot.data[index]
                                      ["idcidade"]
                                          .toString(),
                                      snapshot.data[index]
                                      ["nrofone"]
                                          .toString(),
                                      snapshot.data[index]
                                      ["arquivo"]
                                          .toString()))
                                  : AssetImage(
                                  'imagens/no-image-icon.png'),
                              placeholder: AssetImage(
                                  'imagens/carrega_produtos.gif')),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 6),
                                    child: Center(
                                        child: Text(
                                            snapshot.data[index]
                                            ["nomedono"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Theme.of(
                                                    context)
                                                    .primaryColor,
                                                fontSize: 16.0,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontFamily: "LatoBlackItalic"
                                            ),
                                            maxLines: 3,
                                            textAlign: TextAlign
                                                .center)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(bottom: 10),
                            child: Text(
                              snapshot.data[index]
                              ["nrofone_formatado"]
                                  .toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "LatoBlackItalic"
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(bottom: 10),
                            child: Text(
                              snapshot.data[index]["cidade"]
                                  .toString() +
                                  "-" +
                                  snapshot.data[index]["uf"]
                                      .toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "LatoBlackItalic"
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              snapshot.data[index]["endereco"]
                                  .toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "LatoBlackItalic"
                              ),
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(10),
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
                    )));
              /*InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ClienteDetalhe()));
                },
                child: Card(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FadeInImage(
                        height: 80,
                        width: 120,
                        image: AssetImage('imagens/semtelefone.png'),
                        placeholder:
                            AssetImage('imagens/carrega_produtos.gif')),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Center(
                                  child: Text(
                                      snapshot.data[index]["nomedono"]
                                          .toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 3,
                                      textAlign: TextAlign.center)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        snapshot.data[index]["nrofone_formatado"].toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        snapshot.data[index]["cidade"].toString() +
                            "-" +
                            snapshot.data[index]["uf"].toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        snapshot.data[index]["endereco"].toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                    )
                  ],
                )));*/
          }),
      ListView.builder(
          padding: EdgeInsets.all(4.0),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: FadeInImage(
                        height: 80,
                        width: 190,
                        fit: BoxFit.fill,
                        image: snapshot.data[index]
                        ["arquivo"]
                            .toString() !=
                            ""
                            ? NetworkImage(
                            getUrlFotoPrincipal(
                                snapshot.data[index]
                                ["idcidade"]
                                    .toString(),
                                snapshot.data[index]
                                ["nrofone"]
                                    .toString(),
                                snapshot.data[index]
                                ["arquivo"]
                                    .toString()))
                            : AssetImage(
                            'imagens/no-image-icon.png'),
                        placeholder: AssetImage(
                            'imagens/carrega_produtos.gif')),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data[index]["nomedono"].toString(),
                            style: TextStyle(
                                color: Theme.of(
                                    context)
                                    .primaryColor,
                                fontSize: 16.0,
                                fontWeight:
                                FontWeight
                                    .bold,
                                fontFamily: "LatoBlackItalic"
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            snapshot.data[index]["nrofone_formatado"],
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "LatoBlackItalic"
                            ),
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          })
    ]);
  }
}
