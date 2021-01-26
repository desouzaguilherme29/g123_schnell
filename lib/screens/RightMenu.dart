import 'package:flutter/material.dart';

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
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(38, 36, 99, 1.0),
              image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('imagens/logo_empresa.jpeg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Color.fromRGBO(38, 36, 99, 1.0),),
            title: Text('Dados Pessoais', style: TextStyle(fontSize: 16)),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket, color: Color.fromRGBO(38, 36, 99, 1.0)),
            title: Text('Meus Pedidos', style: TextStyle(fontSize: 16)),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.local_library, color: Color.fromRGBO(38, 36, 99, 1.0)),
            title: Text('Nossas Lojas', style: TextStyle(fontSize: 16)),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Color.fromRGBO(38, 36, 99, 1.0)),
            title: Text('Contato', style: TextStyle(fontSize: 16)),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
