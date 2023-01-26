import 'package:flutter/material.dart';

import '../../../../themes/themes.dart';
import '../custom_text_field.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        inputType: TextInputType.visiblePassword,
        hintText: "",
        obscure: false,
        func: (value) => "alo",
        fieldColor: customGray1,
        label: "Username");
  }
}
