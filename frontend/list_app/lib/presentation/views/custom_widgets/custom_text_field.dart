import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.inputType,
      required this.hintText,
      required this.obscure,
      required this.func,
      required this.fieldColor,
      required this.label,
      Key? key})
      : super(key: key);

  final TextInputType inputType;
  final String? hintText;
  final bool obscure;
  final void Function(String)? func;
  final Color fieldColor;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            label!,
            // style: TextStyle(),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Material(
          borderRadius: BorderRadius.circular(30),
          color: fieldColor,
          child: TextField(
            onChanged: func,
            keyboardType: inputType,
            decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                contentPadding: const EdgeInsets.only(left: 20)),
            obscureText: obscure,
            autocorrect: false,
          ),
        ),
      ],
    );
  }
}
