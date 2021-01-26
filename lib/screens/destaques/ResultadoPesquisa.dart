import 'package:flutter/material.dart';
import 'package:g123_schnell/model/url_service.dart';
import 'package:g123_schnell/screens/ClienteDetalhe.dart';
import 'package:g123_schnell/templates/loading.dart';
import 'package:g123_schnell/templates/pesquise_vazia.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ResultadoPesquisa extends StatefulWidget {
  @override
  _ResultadoPesquisaState createState() => _ResultadoPesquisaState();
}

class _ResultadoPesquisaState extends State<ResultadoPesquisa> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _textEditingController = TextEditingController();

  Future _getProdutos() async {
    http.Response response;

    if (_textEditingController.text != "")
      response = await http.get(getURLPatrocinadosRecentes(filtro: _textEditingController.text));

    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            key: _scaffoldkey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Resultado da Pesquisa"),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.grid_on),
                  ),
                  Tab(
                    icon: Icon(Icons.list),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    autofocus: true,
                    controller: _textEditingController,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                        hintText: "Pesquise aqui seu contato...",
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)))),
                    onSubmitted: (pesquisa) {
                      if (pesquisa.isNotEmpty || pesquisa != "")
                        setState(() {});
                      else
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text('Campo pesquisa está vazio!'),
                        ));
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _getProdutos(),
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
            )));
  }

  Widget _createGradeTable(BuildContext context, AsyncSnapshot snapshot) {
    return TabBarView(physics: NeverScrollableScrollPhysics(), children: [
      GridView.builder(
          padding: EdgeInsets.all(4.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 0.65,
          ),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ClienteDetalhe()));
                },
                child: Card(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClienteDetalhe()));
                      },
                      child: FadeInImage(
                          height: 80,
                          width: 120,
                          image: AssetImage(
                              'imagens/semtelefone.png'),
                          placeholder: AssetImage(
                              'imagens/carrega_produtos.gif')),
                    ),
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
                                      ),
                                      maxLines: 3,
                                      textAlign:
                                      TextAlign.center)),
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
                        ),
                        maxLines: 1,
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
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        snapshot
                            .data[index]["endereco"]
                            .toString(),
                        style: TextStyle(
                          color:
                          Theme.of(context).primaryColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                    )
                  ],
                )));
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
                        height: 70,
                        width: 120,
                        image: AssetImage(
                            'imagens/semtelefone.png'),
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
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          Text(
                            snapshot.data[index]["nrofone_formatado"],
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
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
