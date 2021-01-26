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
          children: <Widget>[
            Container(
              height: 100,
              child: Column(
                children: [
                  //Image.asset("imagens/telefone_carregando.gif",height: 80,),
                  Text("Use a caixa de pesquisa acima para pesquisar...")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
