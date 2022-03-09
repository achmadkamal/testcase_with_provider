import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(String?) validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool obscureText;

  const TextFormWidget({
    Key? key,
    required this.label,
    required this.hintText,
    required this.validator,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
              suffixIcon: suffixIcon,
            ),
            validator: (value) => validator(value!),
          ),
        )
      ],
    );
  }
}
