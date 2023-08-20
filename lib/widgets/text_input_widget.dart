import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import '../utils/colors.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
        required TextEditingController controller,
        required String hint, required validate, required obscureText, required inputType,})
      : _controller = controller,
        _hint = hint,_validate = validate,_obscureText = obscureText,_inputType = inputType;
  final _validate;
  final String _hint;
  final TextEditingController _controller;
  final bool _obscureText ;
  final _inputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: _inputType,
      obscureText: _obscureText,
      validator: _validate,
      controller: _controller,
      style: TextStyle(fontSize: 14, color: textColor),
      decoration: InputDecoration(
          fillColor: Color(0xFFFAFAFA),
          border: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: BorderRadius.circular(5)),
          hintText: _hint,
          hintStyle: TextStyle(fontSize: 14, color: Color(0x33000000))),
    );
  }
}