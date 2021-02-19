import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:g123_schnell/templates/input_field.dart';
import 'package:g123_schnell/templates/CabPages.dart';
import 'package:url_launcher/url_launcher.dart';

class ChamarWhats extends StatefulWidget {
  @override
  _ChamarWhatsState createState() => _ChamarWhatsState();
}

class _ChamarWhatsState extends State<ChamarWhats> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerNumero = new TextEditingController();

  _launchURL(String urlOpen) async {
    if (await canLaunch(urlOpen)) {
      await launch(urlOpen);
    } else {
      throw 'Could not launch $urlOpen';
    }
  }

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
                            keytype: TextInputType.number,
                            length: 11,
                            maxlength: 11,
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
                          _launchURL("https://api.whatsapp.com/send?phone=+55"+ controllerNumero.text);
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
