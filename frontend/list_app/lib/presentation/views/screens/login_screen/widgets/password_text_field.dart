import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../login_screen_providers.dart';

class LoginPasswordTextField extends ConsumerWidget {
  const LoginPasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
        inputType: TextInputType.visiblePassword,
        hintText: "",
        obscure: true,
        func: (value) => ref
            .read(loginPasswordControllerProvider.notifier)
            .update((state) => value),
        fieldColor: customGray1,
        label: "Password");
  }
}
