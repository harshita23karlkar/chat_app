import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.icon,
      required this.hintText,
      required this.isPassword,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 235, 232, 232),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
