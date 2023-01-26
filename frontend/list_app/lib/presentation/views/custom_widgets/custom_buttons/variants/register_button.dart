import 'package:flutter/material.dart';

import '../../../util/route_manager.dart';
import '../custom_button.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: 155,
      height: 50,
      fontSize: 24,
      text: "Register",
      borderRadius: 100,
      func: () => {Navigator.pushReplacementNamed(context, Routes.profile)},
    );
  }
}
