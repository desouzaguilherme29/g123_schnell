import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CabecalhoPaginas extends StatefulWidget {
  @override
  _CabecalhoPaginasState createState() => _CabecalhoPaginasState();

  String title;
  bool tp_voltar;

  CabecalhoPaginas({@required this.title, @required this.tp_voltar});
}

class _CabecalhoPaginasState extends State<CabecalhoPaginas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              widget.tp_voltar ?
              GestureDetector(
                child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.white,),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ) : Container(),
              Padding(padding: EdgeInsets.only(left: 30),
                child:Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "LatoBlackItalic"
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
