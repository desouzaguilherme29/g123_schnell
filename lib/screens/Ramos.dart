import 'package:flutter/material.dart';
import 'package:g123_schnell/model/url_service.dart';
import 'package:g123_schnell/screens/destaques/ResultadoPesquisa.dart';
import 'package:g123_schnell/templates/loading.dart';
import 'package:g123_schnell/templates/pesquise_vazia.dart';
import 'package:g123_schnell/templates/template_error.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:side_header_list_view/side_header_list_view.dart'
    show SideHeaderListView;

class Ramos extends StatefulWidget {
  @override
  _RamosState createState() => _RamosState();
}

class _RamosState extends State<Ramos> {
  TextEditingController _controllerPesquisa = new TextEditingController();
  var list;

  Future _getRamos() async {
    http.Response response;

    try {
      if (_controllerPesquisa.text == null || _controllerPesquisa.text.isEmpty)
        response = await http.get(getURLListaRamos(filtro: ""));
      else
        response =
            await http.get(getURLListaRamos(filtro: _controllerPesquisa.text));

      return json.decode(response.body);
    } on Exception catch (_) {
      print(Exception);
    }
  }

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
                  'Ramos de atividade',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "LatoBlackItalic"),
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
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        height: 55,
                        child: TextField(
                          style: TextStyle(fontSize: 15),
                          controller: _controllerPesquisa,
                          decoration: InputDecoration(
                              hintText: "Pesquisar...",
                              hintStyle:
                                  TextStyle(fontFamily: "LatoBlackItalic"),
                              suffixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)))),
                          onSubmitted: (pesquisa) {
                            setState(() {});
                          },
                          onChanged: (pesquisa) {
                            if (pesquisa.isEmpty || pesquisa == "")
                              setState(() {});
                          },
                        ),
                      )),
                  Expanded(
                    child: FutureBuilder(
                      future: _getRamos(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Loading();
                            break;
                          default:
                            if (snapshot.hasError)
                              return ErroCarregarDados();
                            else
                              return _carregaGrupos(context, snapshot);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carregaGrupos(BuildContext context, AsyncSnapshot snapshot) {
    return snapshot.data.length > 0
        ? SideHeaderListView(
            itemCount: snapshot.data.length,
            padding: new EdgeInsets.all(16.0),
            itemExtend: 48.0,
            headerBuilder: (BuildContext context, int index) {
              return new SizedBox(
                  width: 32.0,
                  child: new Text(
                      snapshot.data[index]["descricao"].substring(0, 1),
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "LatoBlackItalic")));
            },
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  margin: EdgeInsets.all(3),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResultadoPesquisa()));
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 5,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              snapshot.data[index]["descricao"]
                                  .toString()
                                  .substring(
                                      0,
                                      (snapshot.data[index]["descricao"]
                                                      .toString())
                                                  .length >
                                              50
                                          ? 50
                                          : (snapshot.data[index]["descricao"]
                                                  .toString())
                                              .length),
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "LatoBlackItalic"),
                            ),
                          ),
                        ],
                      )));
            },
            hasSameHeader: (int a, int b) {
              return snapshot.data[a]["descricao"].substring(0, 1) ==
                  snapshot.data[b]["descricao"].substring(0, 1);
            },
          )
        : PesquisaVazia();
  }
}
