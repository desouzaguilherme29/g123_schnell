import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:g123_schnell/screens/chamarWhats/input_field.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

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
      appBar: AppBar(
        title: Text("Iniciar Conversa no Whats"),
      ),
      body: ListView(
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
                    fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Basta preencher o campo do telefone com o número desejado",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Pressionar 'Chamar' e Pronto!",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black
                  ),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
