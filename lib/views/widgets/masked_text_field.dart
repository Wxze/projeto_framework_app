import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskedTextField extends StatelessWidget {
  const MaskedTextField(
      {super.key,
      required this.controller,
      required this.text,
      required this.icon,
      this.validator,
      this.keyboardType,
      required this.maskFormatter});

  final TextEditingController controller;
  final String text;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final MaskTextInputFormatter maskFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFd2dae9),
        prefixIcon: Icon(icon),
        prefixIconConstraints:
            const BoxConstraints(minHeight: 32, minWidth: 32),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFF1d4491),
        )),
        hintText: text,
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF000000),
      ),
    );
  }
}
