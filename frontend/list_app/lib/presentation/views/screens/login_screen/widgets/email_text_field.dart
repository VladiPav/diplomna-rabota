import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../login_screen_providers.dart';

class LoginEmailTextField extends ConsumerWidget {
  const LoginEmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
      inputType: TextInputType.emailAddress,
      hintText: "",
      obscure: false,
      func: (value) => ref
          .read(loginEmailControllerProvider.notifier)
          .update((state) => value),
      fieldColor: customGray1,
      label: "Email",
    );
  }
}
