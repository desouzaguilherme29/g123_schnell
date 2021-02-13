import 'package:flutter/material.dart';
import 'package:search_cep/search_cep.dart';
import 'package:search_cep/src/postmon/postmon_search_cep.dart';


class BuscarCep extends StatefulWidget {
  @override
  _BuscarCepState createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {

Future<void> _getCEP() async {



}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("CEP"),
        onPressed: () async {
          final viaCepSearchCep = ViaCepSearchCep();

          final cepsJSON = await viaCepSearchCep.searchForCeps(
              uf: 'RS',
              cidade: 'Porto Alegre',
              logradouro: 'Domingos',
              returnType: SearchCepsType.json,);

          print(cepsJSON.fold((_) => null, (data) => data));
        },
      ),
    );
  }
}
