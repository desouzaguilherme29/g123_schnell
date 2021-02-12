import 'package:flutter/material.dart';
import 'package:g123_schnell/screens/destaques/ResultadoPesquisa.dart';

class PesquisaContato extends StatefulWidget {
  @override
  _PesquisaContatoState createState() => _PesquisaContatoState();
}

class _PesquisaContatoState extends State<PesquisaContato> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 50,
            child: TextField(
              style: TextStyle(fontSize: 15),
              readOnly: true,
              decoration: InputDecoration(
                  hintText: "Pesquisar...",
                  hintStyle: TextStyle(color: Colors.black, fontFamily: "LatoBlackItalic"),
                  suffixIcon: Icon(Icons.search,color: Colors.black,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)))),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResultadoPesquisa()));
              },
            ),
          )),
    );
  }
}
