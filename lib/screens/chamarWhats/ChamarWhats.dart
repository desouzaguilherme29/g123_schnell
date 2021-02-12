import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:g123_schnell/screens/chamarWhats/input_field.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:g123_schnell/templates/CabPages.dart';

class ChamarWhats extends StatefulWidget {
  @override
  _ChamarWhatsState createState() => _ChamarWhatsState();
}

class _ChamarWhatsState extends State<ChamarWhats> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerNumero = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Color.fromRGBO(2, 30, 105, 1.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CabecalhoPaginas(title: 'Chamar no Whatsapp',tp_voltar: true,),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,6,0,0),
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
                          InputField(
                            hint: "Número do Whatsapp",
                            obscure: false,
                            icon: Icons.phone,
                            controller: controllerNumero,
                            validateText: "Deve conter pelo menos 10 dígitos.",
                            autoFocus: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(50),
                    child: InkWell(
                      onTap: () {
                        if (formKey.currentState.validate()) {
                          FlutterOpenWhatsapp.sendSingleMessage(
                              "+55" + controllerNumero.text, "Olá");
                        }
                      },
                      child: Container(
                        width: 320,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(69, 199, 99, 1.0),
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset("imagens/whatsapp.png"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Text(
                                  "Chamar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "LatoBlackItalic",
                                      letterSpacing: 0.3),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("É muito fácil de usar:",textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black, fontFamily: "LatoBlackItalic"
                          ),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Basta preencher o campo do telefone com o número desejado",textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black, fontFamily: "LatoBlackItalic"
                          ),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Pressionar 'Chamar' e Pronto!",textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black, fontFamily: "LatoBlackItalic"
                          ),),
                        ),
                      ],
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
