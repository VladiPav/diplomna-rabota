import 'package:flutter/material.dart';

import '../../../../themes/themes.dart';
import '../custom_text_field.dart';


class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      inputType: TextInputType.emailAddress,
      hintText: "",
      obscure: false,
      func: (value) => "helloThere",
      fieldColor: customGray1,
      label: "Email",

    );
  }
}
