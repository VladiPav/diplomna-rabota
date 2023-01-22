import 'package:flutter/material.dart';
import 'package:frontend/presentation/themes/themes.dart';
import 'package:frontend/presentation/views/custom_widgets/custom_text_field.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        inputType: TextInputType.visiblePassword,
        hintText: "",
        obscure: true,
        func: (value) => "alo",
        fieldColor: customGray1,
        label: "Password");
  }
}
