import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {super.key,
      required this.formController,
      required this.icon,
      required this.hintText,
      this.validator,
      this.keyboardType});

  final IconData icon;
  final String hintText;
  final TextEditingController formController;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: formController,
      validator: validator,
      keyboardType: keyboardType,
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
        hintText: hintText,
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
