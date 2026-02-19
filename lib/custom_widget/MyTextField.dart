import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatefulWidget {
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  const MyTextField({super.key, this.hintText, this.obscureText = false, this.controller,});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        prefixIconColor: kGrey,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: kGrey),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: kprimaryBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: kprimaryBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: kfaintgrey),
        ),
      ),
    );
  }
}
