import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData icon;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.obscureText = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
