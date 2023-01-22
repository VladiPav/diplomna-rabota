import 'package:flutter/material.dart';

import '../../../themes/themes.dart';
import '../custom_text_field.dart';

class ConfirmPasswordTextField extends StatelessWidget {
  const ConfirmPasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        inputType: TextInputType.visiblePassword,
        hintText: "",
        obscure: true,
        func: (value) => "alo",
        fieldColor: customGray1,
        label: "Confirm password");
  }
}
