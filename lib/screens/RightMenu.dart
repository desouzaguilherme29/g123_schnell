import 'package:flutter/material.dart';
import 'package:g123_schnell/screens/buscaCep.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "LatoLightItalic"),
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(2, 30, 105, 1.0),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('imagens/logo_empresa.jpeg'))),
          ),
          ListTile(
            leading: Icon(
              Icons.add_box,
              color: Color.fromRGBO(2, 30, 105, 1.0),
            ),
            title: Text('Incluir telefone',
                style: TextStyle(fontSize: 18, fontFamily: "LatoMedium")),
            onTap: () => {},
          ),
          ListTile(
            leading:
                Icon(Icons.location_on, color: Color.fromRGBO(2, 30, 105, 1.0)),
            title: Text('Buscar CEP',
                style: TextStyle(fontSize: 18, fontFamily: "LatoMedium")),
            onTap: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => BuscarCep()))
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color.fromRGBO(2, 30, 105, 1.0)),
            title: Text('Sobre a Schnell',
                style: TextStyle(fontSize: 18, fontFamily: "LatoMedium")),
            onTap: () => {},
          )
        ],
      ),
    );
  }
}
