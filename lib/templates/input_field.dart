import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final String validateText;
  final bool autoFocus;
  final TextEditingController controller;
  final TextInputType keytype;
final int length;
final int maxlength;

  InputField({@required this.hint,@required  this.obscure,@required  this.icon,@required  this.controller,@required  this.validateText, @required this.autoFocus, @required this.keytype, @required int this.length, @required this.maxlength});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.white24,
        width: 0.5,
      ))),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if(value.isEmpty || value.length < length){
            return validateText;
          }
        },
        autofocus: autoFocus,
        controller: controller,
        obscureText: obscure,
        style: TextStyle(color: Colors.black38),
        keyboardType: keytype,
maxLength: maxlength,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Color.fromRGBO(2, 30, 105, 1.0),
              size: 28,
            ),
            //border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                letterSpacing: 0.9,
                fontFamily: "LatoLightItalic"),
            contentPadding:
                EdgeInsets.only(top: 20, right: 20, bottom: 20, left: 5)),
      ),
    );
  }
}
