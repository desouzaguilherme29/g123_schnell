import 'package:flutter/material.dart';

class ErroCarregarDados extends StatefulWidget {
  @override
  _ErroCarregarDadosState createState() => _ErroCarregarDadosState();
}

class _ErroCarregarDadosState extends State<ErroCarregarDados> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "❌",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Falha na conexão!",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Não foi possível carregar os informações. Verifique sua conexão com a internet e tente novamente.",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ));
  }
}
