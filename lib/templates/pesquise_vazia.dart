import 'package:flutter/material.dart';

class PesquisaVazia extends StatefulWidget {
  @override
  _PesquisaVaziaState createState() => _PesquisaVaziaState();
}

class _PesquisaVaziaState extends State<PesquisaVazia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('imagens/semresultados.png'),
              height: 150,
            ),
            Text(
              "Não há resultados.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: "LatoLightItalic"),
            ),
          ],
        ),
      )
    );
  }
}
