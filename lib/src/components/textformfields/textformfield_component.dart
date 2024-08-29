import 'package:flutter/material.dart';
import 'package:unijobs/src/theme/theme_color.dart';

class TextFormFieldComponent extends StatefulWidget {
  final String labelText;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final TextEditingController controller;
  const TextFormFieldComponent({super.key, required this.controller, required this.labelText, this.validator, required this.inputType, required this.obscure});

  @override
  State<TextFormFieldComponent> createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      obscureText: widget.obscure,
      controller: widget.controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorSchemeManagerClass.colorDanger,
            width: 2,
          ),
        ),
        labelText: widget.labelText,
      ),
      validator: widget.validator
    );
  }
}
