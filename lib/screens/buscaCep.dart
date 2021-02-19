import 'dart:convert';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:g123_schnell/model/url_service.dart';
import 'package:g123_schnell/templates/input_field.dart';
import 'package:g123_schnell/templates/CabPages.dart';
import 'package:g123_schnell/templates/loading.dart';
import 'package:g123_schnell/templates/pesquise_vazia.dart';
import 'package:g123_schnell/templates/template_error.dart';
import 'package:search_cep/search_cep.dart';
import 'package:search_cep/src/postmon/postmon_search_cep.dart';
import 'package:http/http.dart' as http;

class BuscarCep extends StatefulWidget {
  @override
  _BuscarCepState createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {
  GlobalKey<FormState> formKeyCep = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEnd = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerUF = TextEditingController();
  TextEditingController controllerCidade = TextEditingController();
  TextEditingController controllerLogradouro = TextEditingController();
  TextEditingController controllerCEP = TextEditingController();
  String tp_busca = "cep";

  @override
  Future _getCEP() async {
    http.Response response;
    String url;

    if (tp_busca == "cep") {
      if (formKeyCep.currentState.validate()) {
        url = "https://viacep.com.br/ws/" + controllerCEP.text + "/json/";
      }

    } else {
      if (formKeyEnd.currentState.validate()) {
        url = "https://viacep.com.br/ws/" +
            controllerUF.text.trim() +
            "/" +
            controllerCidade.text.trim() +
            "/" +
            controllerLogradouro.text.trim() +
            "/json/";
      }
    }

    try {
      if (url != "") {
        response = await http.get(url);

        if (tp_busca == "cep") {
          if (response.body.contains("erro")) {
            return "";
          }
          return json.decode("[" + response.body + "]");
        } else {
          return json.decode(response.body);
        }
      }
    } on Exception catch (ex) {
      print(ex);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CabecalhoPaginas(
            title: 'Buscar endereço',
            tp_voltar: true,
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
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          CustomRadioButton(
                            elevation: 3,
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.435,
                            unSelectedColor: Colors.white,
                            buttonLables: [
                              'Endereço',
                              'CEP',
                            ],
                            buttonValues: [
                              "end",
                              "cep",
                            ],
                            enableShape: true,
                            buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "LatoBlackItalic")),
                            radioButtonValue: (value) {
                              setState(() {
                                tp_busca = value;
                              });
                              print(tp_busca);
                            },
                            defaultSelected: tp_busca,
                            selectedColor: Color.fromRGBO(2, 30, 105, 1.0),
                          ),
                          tp_busca == "cep"
                              ? Form(
                                  key: formKeyCep,
                                  child: InputField(
                                    hint: "CEP",
                                    obscure: false,
                                    icon: Icons.location_on,
                                    controller: controllerCEP,
                                    validateText: "Insira o CEP, com 8 dígitos ex.: 85601000",
                                    autoFocus: false,
                                    keytype: TextInputType.number,
                                    length: 8,
                                    maxlength: 8,
                                  ))
                              : Container(),
                          tp_busca == "end"
                              ? Form(
                                  key: formKeyEnd,
                                  child: Column(
                                    children: [
                                      InputField(
                                        hint: "UF",
                                        obscure: false,
                                        icon: Icons.location_on,
                                        controller: controllerUF,
                                        validateText: "Campo \"UF\" é obrigatório, e precisa ter pelo menos 2 dígitos",
                                        autoFocus: false,
                                        keytype: TextInputType.text,
                                        length: 2,
                                        maxlength: 2,
                                      ),
                                      InputField(
                                        hint: "Cidade",
                                        obscure: false,
                                        icon: Icons.location_on,
                                        controller: controllerCidade,
                                        validateText: "Campo \"cidade\" é obrigatório, e precisa ter pelo menos 3 dígitos",
                                        autoFocus: false,
                                        keytype: TextInputType.text,
                                        length: 3,
                                        maxlength: 100,
                                      ),
                                      InputField(
                                        hint: "Logradouro",
                                        obscure: false,
                                        icon: Icons.location_on,
                                        controller: controllerLogradouro,
                                        validateText: "Campo \"logradouro\" é obrigatório, e precisa ter pelo menos 3 dígitos",
                                        autoFocus: false,
                                        keytype: TextInputType.text,
                                        length: 3,
                                        maxlength: 100,
                                      )
                                    ],
                                  ))
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(50),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {});
                      },
                      child: Container(
                        width: 320,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(2, 30, 105, 1.0),
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: Text(
                          "Consultar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                              fontFamily: "LatoBlackItalic",
                              letterSpacing: 0.3),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 450,
                    child: FutureBuilder(
                      future: _getCEP(),
                      // ignore: missing_return
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _createGradeTable(BuildContext context, AsyncSnapshot snapshot) {
  return snapshot.data.length > 0
      ? ListView.builder(
          padding: EdgeInsets.all(4.0),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Logradouro/Nome",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "LatoLightItalic",
                                      color: Colors.grey),
                                ),
                                Text(
                                  snapshot.data[index]["logradouro"]
                                          .toString() +
                                      "-" +
                                      snapshot.data[index]["complemento"]
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "LatoBlackItalic",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(),
                                Text(
                                  "Bairro/Distrito",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "LatoLightItalic",
                                      color: Colors.grey),
                                ),
                                Text(
                                  snapshot.data[index]["bairro"].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "LatoBlackItalic",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(),
                                Text(
                                  "Lacalidade/UF",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "LatoLightItalic",
                                      color: Colors.grey),
                                ),
                                Text(
                                  snapshot.data[index]["localidade"]
                                          .toString() +
                                      "-" +
                                      snapshot.data[index]["uf"].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "LatoBlackItalic",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(),
                                Text(
                                  "CEP",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "LatoLightItalic",
                                      color: Colors.grey),
                                ),
                                Text(
                                  snapshot.data[index]["cep"].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "LatoBlackItalic",
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          })
      : PesquisaVazia();
}
